import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/signin/sign_in.dart';

Widget appOnBoardingPage(PageController controller, BuildContext context,
    {String imagePath = "assets/images/reading.png",
    String title = "",
    String subTitle = "",
    index = 0}) {
  return Column(
    children: [
      Image.asset(imagePath),
      Container(
        margin: const EdgeInsets.only(top: 15),
        child: text24Normal(text: title),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: text16Normal(text: subTitle),
      ),
      _nextButton(index, controller, context)
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 2) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SignIn()));
      }
    },
    child: Container(
      width: 325,
      height: 45,
      margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
      decoration: appBoxShadow(),
      child: Center(
          child:
              text16Normal(text: "next", color: AppColors.primaryBackground)),
    ),
  );
}
