import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOnBoardingPage extends StatelessWidget {
  final PageController controller;
  final BuildContext context;
  final String imagePath;
  final String title;
  final String subTitle;
  final int index;

  const AppOnBoardingPage(
      {Key? key,
      required this.controller,
      required this.context,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 360,
          child: Image.asset(imagePath), // fix height avoid flashing
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: text24Normal(text: title),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text16Normal(text: subTitle),
        ),
        _nextButton(index, controller, context)
      ],
    );
  }
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 2) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        // first time arrive this
        Global.storageService.setBool(AppConstants.OPEN_FIRST_TIME_KEY, true);
        Navigator.pushNamed(context, "/signIn");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => const SignIn()));
      }
    },
    child: Container(
      width: 325,
      height: 45,
      margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
      decoration: appBoxShadow(),
      child: Center(
          child: Text16Normal(
              text: index < 2 ? "Next" : "Get Started",
              color: AppColors.primaryBackground)),
    ),
  );
}
