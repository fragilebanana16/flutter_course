import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';

class AppTheme {
  static ThemeData appThemeData = ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.primaryText)));
}