import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: bottomContainer(icon: Icons.home),
      activeIcon:
          bottomContainer(icon: Icons.home, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Home"),
  BottomNavigationBarItem(
      icon: bottomContainer(icon: Icons.search),
      activeIcon:
          bottomContainer(icon: Icons.search, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Search"),
  BottomNavigationBarItem(
      icon: bottomContainer(icon: Icons.access_alarm),
      activeIcon: bottomContainer(
          icon: Icons.access_alarm, color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Other")
];

Widget bottomContainer(
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
