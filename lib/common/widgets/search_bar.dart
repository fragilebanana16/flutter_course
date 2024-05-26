import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/app_textfields.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 280.w,
        height: 40.h,
        decoration: appBoxShadow(
            color: AppColors.primaryBackground,
            border: Border.all(color: AppColors.primaryFourElementText)),
        child: Row(
          children: [
            Container(
                child: appImage(
                    icon: Icons.search, size: 24, color: AppColors.primaryText),
                margin: EdgeInsets.only(left: 17.w)),
            Container(
              width: 240.w,
              height: 40.h,
              child: appTextOnlyField(
                  hintText: "Search...", width: 240, height: 40),
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 40.w,
          height: 40.h,
          child: appImage(
              icon: Icons.settings, color: AppColors.primaryBackground),
          decoration:
              appBoxShadow(border: Border.all(color: AppColors.primaryElement)),
        ),
      )
    ],
  );
}
