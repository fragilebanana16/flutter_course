import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/model/todoItem.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/repo/todoListRepo.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/todo_home.dart';

class TodoModal {
  List<String> subTasks = <String>['Call the restaurant ', 'Ask for the date '];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  onAddTaskTap(TextEditingController titleEditingController) async {
    // TodoListRepo.whereIsMyDb();
    print(titleEditingController.value.text);
    final title = titleController.value.text;
    // final description = descriptionController.value.text;
    if (title.isEmpty) {
      return;
    }

    List<TodoItem>? todoList = await TodoListRepo.getAllNotes();
    if (todoList != null) {
      for (var i = 0; i < todoList!.length; i++) {
        print(todoList[i].title);
      }
    }
    print('after');
    final TodoItem model = TodoItem(
      title: title,
      description: 'dddd',
    );
    await TodoListRepo.addNote(model);
    todoList = await TodoListRepo.getAllNotes();
    if (todoList != null) {
      for (var i = 0; i < todoList!.length; i++) {
        print(todoList[i].title);
      }
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => TodoHome()),
    // );
  }

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 80,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height / 25,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(175, 30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 340,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                TodoListCustomColors.PurpleLight,
                                TodoListCustomColors.PurpleDark,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: TodoListCustomColors.PurpleShadow,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          child: Image.asset('assets/images/fab-delete.png'),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          const Text(
                            '每日诗词-干就完了',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: titleController,
                              autofocus: true,
                              style: const TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.normal),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 60,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1.0,
                                  color: TodoListCustomColors.GreyBorder,
                                ),
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: TodoListCustomColors.GreyBorder,
                                ),
                              ),
                            ),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: <Widget>[
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        width: 10.0,
                                        margin: const EdgeInsets.only(right: 4),
                                        decoration: const BoxDecoration(
                                          color:
                                              TodoListCustomColors.YellowAccent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text('高'),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: TodoListCustomColors.GreenIcon,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              TodoListCustomColors.GreenShadow,
                                          blurRadius: 5.0,
                                          spreadRadius: 3.0,
                                          offset: Offset(0.0, 0.0),
                                        ),
                                      ],
                                    ),
                                    child: const Text(
                                      'Work',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        width: 10.0,
                                        margin: const EdgeInsets.only(right: 4),
                                        decoration: const BoxDecoration(
                                          color:
                                              TodoListCustomColors.PurpleIcon,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text('中'),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        width: 10.0,
                                        margin: const EdgeInsets.only(right: 4),
                                        decoration: const BoxDecoration(
                                          color: TodoListCustomColors.BlueIcon,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text('低'),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 10.0,
                                        width: 10.0,
                                        margin: const EdgeInsets.only(right: 4),
                                        decoration: const BoxDecoration(
                                          color:
                                              TodoListCustomColors.OrangeIcon,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text('择日'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: const Text(
                              '日期设定',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: const Row(
                              children: <Widget>[
                                Text(
                                  '今日, 19:00 - 21:00',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 5),
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(Icons.chevron_right),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 150,
                            child: ListView.builder(
                              itemCount: subTasks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  child: TextFormField(
                                    initialValue: subTasks[index],
                                    autofocus: false,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey[850],
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              onAddTaskTap(titleController);
                            },
                            //() {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TodoHome()),
                            // );
                            // Navigator.pop(context);
                            //},
                            // textColor: Colors.white,
                            // padding: const EdgeInsets.all(0.0),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(8.0),
                            // ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    TodoListCustomColors.BlueLight,
                                    TodoListCustomColors.BlueDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: TodoListCustomColors.BlueShadow,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: const Center(
                                child: Text(
                                  'Add task',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}