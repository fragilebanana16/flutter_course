import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';

Widget appIcon(
    {IconData icon = Icons.home,
    double size = 16,
    Color color = AppColors.primaryElement}) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}
