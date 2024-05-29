import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
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
    child: appIcon(icon: icon, size: 24, color: color),
  );
}

Widget appScreens({int index = 0}) {
  List<Widget> screens = [
    const Home(),
    Center(
      child: appIcon(icon: Icons.dangerous, size: 200),
    ),
    Center(
      child: appIcon(icon: Icons.wallet, size: 200),
    ),
    Center(
      child: appIcon(icon: Icons.g_mobiledata, size: 200),
    ),
  ];

  return screens[index];
}
