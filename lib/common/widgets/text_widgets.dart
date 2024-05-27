import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  const Text14Normal({
    Key? key,
    this.text = "",
    this.color = AppColors.primaryThreeElementText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: color, fontSize: 14.sp, fontWeight: FontWeight.normal));
  }
}

Widget text24Normal(
    {String text = "",
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 24.sp, fontWeight: fontWeight));
}

Widget text16Normal(
    {String text = "", Color color = AppColors.primarySecondaryElementText}) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color, fontSize: 16.sp, fontWeight: FontWeight.normal));
}

Widget textUnderline({String text = "underline placeholder"}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
          color: AppColors.primaryText,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 12.sp),
    ),
  );
}
