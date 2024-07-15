import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/model/todoItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoListRepo {
  static const int _version = 1;
  static const String _dbName = "todoList.db";

// /data/user/0/com.example.flutter_course/databases
  static void whereIsMyDb() async {
    var path = await getDatabasesPath();
    print('db file at: ' + path);
  }

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute('''
    CREATE TABLE Todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT
    );
  '''), version: _version);
  }
  //  due_date TEXT NOT NULL,
  //       completed INTEGER NOT NULL,

  //       expected_completion_date TEXT NOT NULL,
  //       pinned INTEGER NOT NULL,
  //       priority INTEGER NOT NULL,
  //       edit_count INTEGER NOT NULL,
  //       completion_date TEXT NOT NULL,
  //       is_archived INTEGER NOT NULL

  static Future<int> addNote(TodoItem todoItem) async {
    final db = await _getDB();
    return await db.insert("Todo", todoItem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(TodoItem todoItem) async {
    final db = await _getDB();
    return await db.update("Todo", todoItem.toJson(),
        where: 'id = ?',
        whereArgs: [todoItem.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(TodoItem todoItem) async {
    final db = await _getDB();
    return await db.delete(
      "Todo",
      where: 'id = ?',
      whereArgs: [todoItem.id],
    );
  }

  static Future<List<TodoItem>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Todo");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => TodoItem.fromJson(maps[index]));
  }
}
