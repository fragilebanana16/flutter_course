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
