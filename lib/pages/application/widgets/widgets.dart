import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
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
    {IconData icon = Icons.home,
    width = 15,
    double height = 15,
    Color color = AppColors.primaryElement}) {
  return SizedBox(
    width: 15.w,
    height: 15.h,
    child: appImageWithColor(icon: icon, color: AppColors.primaryText),
  );
}

Widget appScreens({int index = 0}) {
  List<Widget> screens = [
    Center(
      child: appImage(icon: Icons.dangerous, width: 200, height: 200),
    ),
    Center(
      child: appImage(icon: Icons.wallet, width: 200, height: 200),
    ),
    Center(
      child: appImage(icon: Icons.g_mobiledata, width: 200, height: 200),
    ),
  ];

  return screens[index];
}
