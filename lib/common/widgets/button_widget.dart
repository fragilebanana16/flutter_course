import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/signin/widgets/sign_in_widgets.dart';
import 'package:flutter_course/pages/register/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String buttonName;
  final bool isLogin;
  final double width;
  final double height;
  final BuildContext? context;
  final void Function()? func;
  const AppButton(
      {super.key,
      this.buttonName = '',
      this.width = 325,
      this.height = 50,
      this.isLogin = true,
      this.context,
      this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: appBoxShadow(
            border: Border.all(color: AppColors.primaryFourElementText),
            color: isLogin ? AppColors.primaryElement : Colors.white),
        child: Center(
            child: Text16Normal(
                text: buttonName,
                color: isLogin
                    ? AppColors.primaryBackground
                    : AppColors.primaryText)),
      ),
    );
  }
}
