import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/chat.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/pages/chat/views/homescreen.dart';
import 'package:flutter_course/pages/home/view/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: _bottomContainer(icon: Icons.home),
      activeIcon:
          _bottomContainer(icon: Icons.home, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Home"),
  BottomNavigationBarItem(
      icon: _bottomContainer(icon: Icons.search),
      activeIcon:
          _bottomContainer(icon: Icons.search, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Search"),
  BottomNavigationBarItem(
      icon: _bottomContainer(icon: Icons.access_alarm),
      activeIcon: _bottomContainer(
          icon: Icons.access_alarm, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Other")
];

Widget _bottomContainer(
    {IconData icon = Icons.home, Color color = AppColors.primaryText}) {
  return SizedBox(
    width: 15.w,
    height: 15.h,
    child: AppIcon(icon: icon, size: 24, color: color),
  );
}

Widget appScreens({int index = 0}) {
  ChatModel sourceChat = ChatModel(
    name: "source",
    isGroup: false,
    currentMessage: "source Hi Everyone",
    time: "source 4:00",
    icon: "source person.svg",
    id: 999,
  );

  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),
    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
  ];

  List<Widget> screens = [
    const Home(),
    Center(
      child: AppIcon(icon: Icons.wallet, size: 200),
    ),
    Homescreen(
      chatmodels: chatmodels,
      sourchat: sourceChat,
    )
  ];

  return screens[index];
}
