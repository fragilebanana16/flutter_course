import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/chat.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/pages/chat/views/chatStartScreen.dart';
import 'package:flutter_course/pages/chat/views/homescreen.dart';
import 'package:flutter_course/pages/home/view/home.dart';
import 'package:flutter_course/pages/music/views/musicAppTab.dart';
import 'package:flutter_course/pages/music/views/musicStartView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: _bottomContainer(icon: Icons.home, color: TColor.lightGray),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child:
            _bottomContainer(icon: Icons.home, color: AppColors.primaryElement),
      ),
      backgroundColor: AppColors.primaryBackground,
      label: "Home"),
  BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child:
            _bottomContainer(icon: Icons.music_note, color: TColor.lightGray),
      ),
      activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _bottomContainer(
              icon: Icons.music_note, color: AppColors.primaryElement)),
      backgroundColor: AppColors.primaryBackground,
      label: "Search"),
  BottomNavigationBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _bottomContainer(icon: Icons.chat, color: TColor.lightGray)),
      activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _bottomContainer(
              icon: Icons.chat, color: AppColors.primaryElement)),
      backgroundColor: AppColors.primaryBackground,
      label: "Chat")
];

Widget _bottomContainer(
    {IconData icon = Icons.home, Color color = AppColors.primaryText}) {
  return SizedBox(
    width: 20.w,
    height: 20.h,
    child: AppIcon(icon: icon, size: 24, color: color),
  );
}

Widget appScreens({int index = 0}) {
  List<Widget> screens = [
    const Home(),
    const MusicStartView(),
    // Center(
    //   child: AppIcon(icon: Icons.wallet, size: 200),
    // ),
    ChatStartScreen()
  ];

  return screens[index];
}
