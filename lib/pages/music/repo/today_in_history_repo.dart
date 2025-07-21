import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodayInHistoryRepo {
  Database? _db;

  /// 显式打开数据库
  Future<void> open() async {
    if (_db != null) return; // 防止重复打开
    final path = join(await getDatabasesPath(), 'history_of_today.db');
    _db = await openDatabase(path);
  }

  /// 显式关闭数据库
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  /// 查询某日的历史记录（按年月日过滤）
  Future<List<Map<String, dynamic>>> getRecordsByDate({
    required int year,
    required int month,
    required int day,
  }) async {
    if (_db == null) throw Exception("Database not opened");
    final now = DateTime.now();
    return await _db!.query(
      'today_in_history',
      where: 'month = ? AND day = ?',
      whereArgs: [now.month, now.day],
      orderBy: 'year ASC',
    );
  }

  /// 查询今天的记录（默认按系统时间）
  Future<List<Map<String, dynamic>>> getTodayRecords() async {
    final now = DateTime.now();
    return await getRecordsByDate(
        year: now.year, month: now.month, day: now.day);
  }
}
