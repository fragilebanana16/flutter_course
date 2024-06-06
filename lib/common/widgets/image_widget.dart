import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  const AppIcon(
      {super.key,
      this.icon = Icons.home,
      this.size = 16,
      this.color = AppColors.primaryElement});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size.w,
      color: color,
    );
  }
}
