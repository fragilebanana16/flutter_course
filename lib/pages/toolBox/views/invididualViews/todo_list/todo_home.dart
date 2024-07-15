import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/appBars.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/bottomNavigation.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/bottomSheet.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/fab.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/model/todoItem.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoHome extends StatefulWidget {
  TodoHome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// 添加时展示每日诗词
List<TodoItem> generateFakeData() {
  List<TodoItem> todos = [];
  todos.add(TodoItem(
    title: "Flutter完整功能呈现",
    description: "掌握布局、路由、状态等",
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now(),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 1,
    // editCount: 2,
    // completed: true,
  ));

  todos.add(TodoItem(
    title: "多少看本书",
    description: '多久没看',
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now(),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 1,
    // editCount: 2,
    // completed: false,
  ));

  todos.add(TodoItem(
    title: "Uniapp找到方向",
    description: '多为电商、问诊等商业用途应用，很难激发兴趣',
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now(),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 0,
    // completed: false,
    // editCount: 2,
  ));

  todos.add(TodoItem(
    title: "到底有谁知道",
    description: '是几点钟方向',
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now().add(const Duration(days: -1)),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 2,
    // completed: false,
    // editCount: 2,
  ));

  todos.add(TodoItem(
    title: "密码管理工具",
    description: '默认***，验证后可打开',
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now().add(const Duration(days: -2)),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 2,
    // completed: false,
    // editCount: 3,
  ));

// long long ago
  todos.add(TodoItem(
    title: "Job seek u mf",
    description: 'do it now',
    // dueDate: DateTime.now().add(const Duration(days: 7)),
    // expectedCompletionDate: DateTime.now().add(const Duration(days: -20)),
    // completionDate: DateTime.now().add(const Duration(days: 12)),
    // priority: 2,
    // completed: false,
    // editCount: 3,
  ));
  return todos;
}

class _HomeState extends State<TodoHome> {
  final bottomNavigationBarIndex = 0;
  List<TodoItem> fakeData = generateFakeData();
  TodoModal modal = TodoModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: fullAppbar(context),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // 分今日、昨日、前日、上周、更早
            Container(
              margin: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
              child: const Text(
                '就在今天',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TodoListCustomColors.TextSubHeader),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: fakeData.length,
                itemBuilder: (context, index) {
                  var todoItem = fakeData[index];

                  return Slidable(
                    actionPane: const SlidableDrawerActionPane(),
                    actionExtentRatio: 0.12,
                    secondaryActions: <Widget>[
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: SlideAction(
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: TodoListCustomColors.BlueLight),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => modal.mainBottomSheet(context),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: SlideAction(
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: TodoListCustomColors.TrashRedBackground),
                            child: const Icon(
                              Icons.delete,
                              color: TodoListCustomColors.TrashRed,
                            ),
                          ),
                          onTap: () => print('Delete'),
                        ),
                      )
                    ],
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      padding: const EdgeInsets.fromLTRB(5, 14, 5, 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: const [0.015, 0.015],
                          colors: [
                            switch (1) {
                              // todoItem.priority
                              0 => TodoListCustomColors.GreenIcon,
                              1 => TodoListCustomColors.YellowIcon,
                              2 => TodoListCustomColors.PurpleIcon,
                              _ => TodoListCustomColors.GreyBackground
                            },
                            Colors.white
                          ],
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: TodoListCustomColors.GreyBorder,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          true // todoItem.completed
                              ? Image.asset('assets/images/checked.png')
                              : Image.asset('assets/images/checked-empty.png'),
                          Text(
                            DateFormat('yyyy-MM-dd').format(DateTime
                                .now()), // todoItem.expectedCompletionDate
                            style: const TextStyle(
                                color: TodoListCustomColors.TextGrey),
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              todoItem.title,
                              style: const TextStyle(
                                  color: TodoListCustomColors.TextHeader,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Image.asset('assets/images/bell-small.png'),
                        ],
                      ),
                    ),
                  );
                }),

            Container(
              height: 60,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.YellowIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked.png'),
                  const Text(
                    '07.00 AM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  const SizedBox(
                    width: 180,
                    child: Text(
                      'Go jogging with Christin',
                      style: TextStyle(
                          color: TodoListCustomColors.TextGrey,
                          //fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
            ),
            Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                SlideAction(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: TodoListCustomColors.TrashRedBackground),
                      child: Image.asset('assets/images/trash.png'),
                    ),
                  ),
                  onTap: () => print('Delete'),
                ),
              ],
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.015, 0.015],
                    colors: [TodoListCustomColors.GreenIcon, Colors.white],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: TodoListCustomColors.GreyBorder,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/checked-empty.png'),
                    const Text(
                      '08.00 AM',
                      style: TextStyle(color: TodoListCustomColors.TextGrey),
                    ),
                    Container(
                      width: 180,
                      child: const Text(
                        'Send project file',
                        style: TextStyle(
                            color: TodoListCustomColors.TextHeader,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Image.asset('assets/images/bell-small.png'),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '10.00 AM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Meeting with client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small-yellow.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.PurpleIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '13.00 PM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Email client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 15),
              child: const Text(
                'Tomorrow',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TodoListCustomColors.TextSubHeader),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '07.00 AM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Morning yoga',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.YellowIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '08.00 AM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Sending project file',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '10.00 AM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Meeting with client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small-yellow.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.PurpleIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '13.00 PM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Email client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '13.00 PM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Meeting with client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small-yellow.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.PurpleIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/checked-empty.png'),
                  const Text(
                    '13.00 PM',
                    style: TextStyle(color: TodoListCustomColors.TextGrey),
                  ),
                  Container(
                    width: 180,
                    child: const Text(
                      'Email client',
                      style: TextStyle(
                          color: TodoListCustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Image.asset('assets/images/bell-small.png'),
                ],
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.015, 0.015],
                  colors: [TodoListCustomColors.GreenIcon, Colors.white],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TodoListCustomColors.GreyBorder,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }
}
