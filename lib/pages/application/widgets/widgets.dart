import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: Container(
        width: 15.w,
        height: 15.h,
        child:
            appImageWithColor(icon: Icons.home, color: AppColors.primaryText),
      ),
      label: "Home"),
  BottomNavigationBarItem(
      icon: Container(
        width: 15.w,
        height: 15.h,
        child:
            appImageWithColor(icon: Icons.search, color: AppColors.primaryText),
      ),
      label: "Search")
];
