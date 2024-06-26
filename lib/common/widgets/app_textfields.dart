import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appTextField(
    {TextEditingController? controller,
    String text = "",
    IconData icon = Icons.home,
    String hintText = "Type in...",
    bool obscureText = false,
    void Function(String value)? func}) {
  return Container(
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text14Normal(text: text),
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
                child: AppIcon(icon: icon),
              ),
              appTextOnlyField(
                  controller: controller,
                  hintText: hintText,
                  func: func,
                  obscureText: obscureText)
            ],
          ),
        )
      ],
    ),
  );
}

Widget appTextOnlyField(
    {TextEditingController? controller,
    String hintText = "Type in info",
    double width = 240,
    double height = 50,
    bool obscureText = false,
    void Function(String value)? func}) {
  return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        cursorColor: Colors.grey,
        cursorWidth: 1.0,
        style: const TextStyle(color: Colors.black),
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.h, top: 7.h),
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
        onChanged: (value) => func!(value),
        maxLines: 1,
        autocorrect: false,
        obscureText: obscureText, // password char
      ));
}
