import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/model/todoItem.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/repo/todoListRepo.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/todo_list/todo_home.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoModal {
  List<String> subTasks = <String>['Call the restaurant ', 'Ask for the date '];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedExpectedCompleteDate = DateTime.now();

  bool pinned = false;
  List<String> piorityOptions = <String>['高', '中', '低', '择日', '撞日'];
  List<Color> piorityColor = <Color>[
    TodoListCustomColors.PurpleIcon,
    TodoListCustomColors.OrangeIcon,
    TodoListCustomColors.BlueIcon,
    TodoListCustomColors.DeeppurlpleIcon,
    TodoListCustomColors.YellowBell
  ];

  int selectedPiority = 0;

  List<TodoItem> fakeTodos = [
    TodoItem(
      title: "Flutter完整功能呈现",
      description: "掌握布局、路由、状态等",
      completed: true,
      createdDate: DateTime.now(),
      expectedCompletionDate: DateTime.now().add(const Duration(days: 1)),
      completionDate: DateTime.now().add(const Duration(days: 12)),
      priority: 1,
    ),
    TodoItem(
      title: "123123123123",
      description: "44545445",
      completed: false,
      createdDate: DateTime.now(),
      expectedCompletionDate: DateTime.now().add(const Duration(days: 2)),
      completionDate: DateTime.now().add(const Duration(days: 34)),
      priority: 2,
    )
  ];

  onAddTaskTap(BuildContext context) async {
    // TodoListRepo.whereIsMyDb();
    final title = titleController.value.text;
    final description = descriptionController.value.text;
    if (title.isEmpty) {
      return;
    }

    final TodoItem todoModel = TodoItem(
        title: title,
        description: description,
        expectedCompletionDate: selectedExpectedCompleteDate,
        createdDate: selectedDate,
        completionDate: selectedExpectedCompleteDate,
        pinned: pinned);

    print(todoModel.toJson());
    // List<TodoItem>? todoList = await TodoListRepo.getAllNotes();
    // if (todoList != null) {
    //   for (var i = 0; i < todoList!.length; i++) {
    //     print(todoList[i].title);
    //   }
    // }
    // print('after');
    // final TodoItem model = TodoItem(
    //   title: title,
    //   description: 'dddd',
    //   expectedCompletionDate: DateTime.now(),
    //   createdDate: DateTime.now(),
    // );
    // await TodoListRepo.addNote(model);
    // todoList = await TodoListRepo.getAllNotes();
    // if (todoList != null) {
    //   for (var i = 0; i < todoList!.length; i++) {
    //     print(todoList[i].title);
    //   }
    // }

    Get.to(() => TodoHome());
  }

  mainBottomSheet(BuildContext context, bool isAdd, [TodoItem? todoItem]) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        if (todoItem != null) {
          selectedPiority = todoItem.priority;
          selectedDate = todoItem.createdDate;
          selectedExpectedCompleteDate = todoItem.expectedCompletionDate;
          pinned = todoItem.pinned;
          titleController.text = todoItem.title;
          descriptionController.text =
              todoItem.description == null ? '' : todoItem.description!;
        } else {
          selectedPiority = fakeTodos[0].priority;
          selectedDate = fakeTodos[0].createdDate;
          selectedExpectedCompleteDate = fakeTodos[0].expectedCompletionDate;
          pinned = fakeTodos[0].pinned;
          titleController.text = fakeTodos[0].title;
          descriptionController.text =
              fakeTodos[0].description == null ? '' : fakeTodos[0].description!;
        }

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
              todoItem?.completed == true
                  ? Positioned(
                      top: MediaQuery.of(context).size.height / 25 + 20,
                      right: 30,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(15 / 360),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.red.shade400, width: 5),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Finished',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(fakeTodos[0].completionDate!),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 340,
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
                        const SizedBox(height: 5),
                        const Text(
                          '每日诗词-干就完了',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            controller: titleController,
                            autofocus: true,
                            style: const TextStyle(
                                fontSize: 22, fontStyle: FontStyle.normal),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
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
                          child: StatefulBuilder(
                              builder: (context, setStateBottomSheet) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: piorityOptions.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setStateBottomSheet(() {
                                      selectedPiority = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: selectedPiority == index
                                            ? piorityColor[index]
                                            : TodoListCustomColors
                                                .GreyBorder, // Change to your preferred border color
                                        width:
                                            1.0, // Adjust the border thickness
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: piorityColor[index],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(piorityOptions[index]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Row(
                            children: [
                              StatefulBuilder(
                                  builder: (context, setStateBottomSheet) {
                                return Column(
                                  children: [
                                    const Text(
                                      '创建日期',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "${selectedDate.toLocal()}"
                                                .split(' ')[0],
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              const SizedBox(
                                width: 100,
                              ),
                              StatefulBuilder(
                                  builder: (context, setStateBottomSheet) {
                                return InkWell(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate:
                                                  selectedExpectedCompleteDate,
                                              firstDate: DateTime(2015, 8),
                                              lastDate: DateTime(2101));
                                      if (picked != null &&
                                          picked !=
                                              selectedExpectedCompleteDate) {
                                        setStateBottomSheet(() {
                                          selectedExpectedCompleteDate = picked;
                                        });
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        const Text(
                                          '预计时间',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "${selectedExpectedCompleteDate.toLocal()}"
                                                    .split(' ')[0],
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: SizedBox(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: Scrollbar(
                                  thickness: 0,
                                  child: TextFormField(
                                    initialValue: todoItem?.description != null
                                        ? todoItem!.description
                                        : '',
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            onAddTaskTap(context);
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 60,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  TodoListCustomColors.BlueLight,
                                  TodoListCustomColors.BlueDark,
                                ],
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
                            child: Center(
                              child: Text(
                                isAdd ? 'Add' : 'Update',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Switch(
                              value: pinned, //当前状态
                              onChanged: (value) {},
                            ),
                            const Text('Pinned')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
