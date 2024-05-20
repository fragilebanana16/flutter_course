import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';

Widget appImage(
    {IconData icon = Icons.home, double width = 16, double height = 16}) {
  return Icon(
    icon,
    size: width,
  );
}

Widget appImageWithColor(
    {IconData icon = Icons.home,
    double width = 16,
    double height = 16,
    Color color = AppColors.primaryElement}) {
  return Icon(
    icon,
  );
}
