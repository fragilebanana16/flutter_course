import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/signin/widgets/sign_in_widgets.dart';
import 'package:flutter_course/pages/singup/sign_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appButton(
    {String buttonName = "",
    bool isLogin = false,
    double width = 325,
    double height = 50,
    BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context!, MaterialPageRoute(builder: (context) => SignUp()));
    },
    child: Container(
      width: width.w,
      height: height.h,
      decoration: appBoxShadow(
          border: Border.all(color: AppColors.primaryFourElementText),
          color: isLogin ? AppColors.primaryElement : Colors.white),
      child: Center(
          child: text16Normal(
              text: buttonName,
              color: isLogin
                  ? AppColors.primaryBackground
                  : AppColors.primaryText)),
    ),
  );
}
