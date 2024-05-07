import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/app_shadow.dart';
import '../../../common/widgets/image_widget.dart';

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.only(left: 80.w, right: 80.w, top: 40.h, bottom: 20.h),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _loginButton("assets/images/reading.png"),
      _loginButton("assets/images/music.png"),
      _loginButton("assets/images/music.png"),
    ]),
  );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    onTap: () {
      // todo
    },
    child: SizedBox(
      width: 40.w,
      height: 40.w,
      child: Image.asset(imagePath),
    ),
  );
}

AppBar buildAppBar() {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        height: 1,
      ),
    ),
    centerTitle: true,
    title: text16Normal(text: "Login", color: AppColors.primaryText),
  );
}

Widget appTextField(
    {String text = "",
    String iconName = "",
    String hintText = "Type in...",
    bool obscureText = false}) {
  return Container(
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text14Normal(text: text),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 325.w,
          height: 50.h,
          decoration: appBoxDecorationTextField(),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 14.w),
                child: appImage(imagePath: iconName),
              ),
              Container(
                  width: 200.w,
                  height: 50.h,
                  child: TextField(
                    cursorColor: Colors.grey,
                    cursorWidth: 1.0,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.h),
                        hintText: hintText,
                        hintStyle: TextStyle(fontSize: 14.sp),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                    onChanged: (value) {},
                    maxLines: 1,
                    autocorrect: false,
                    obscureText: obscureText, // password char
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
