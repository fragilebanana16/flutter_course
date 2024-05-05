import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';

BoxDecoration appBoxShadow(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double spreadRadius = 1,
    double blurRadius = 2}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: Offset(0, 1))
      ]);
}
