import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

BoxDecoration appBoxShadow(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double spreadRadius = 1,
    double blurRadius = 2,
    BoxBorder? border}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius.w),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxShadowWithRadius(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double spreadRadius = 1,
    double blurRadius = 2,
    BoxBorder? border}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.h), topRight: Radius.circular(20.h)),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxDecorationTextField(
    {Color color = AppColors.primaryBackground,
    double radius = 15,
    Color borderColor = AppColors.primaryFourElementText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: borderColor));
}

class AppBoxDecoration extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final bool hasMask;
  final VideoItem? videoItem;
  final Function()? func;
  const AppBoxDecoration(
      {Key? key,
      required this.width,
      required this.height,
      required this.imagePath,
      required this.hasMask,
      this.videoItem,
      this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imagePath), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10.w)),
          child: videoItem == null
              ? Container()
              : Stack(
                  children: [
                    Positioned(
                      bottom: 0, // 将蒙版放在底部
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), // 半透明的黑色蒙版
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.w),
                              bottomRight: Radius.circular(10.w),
                            )),
                        height: 44.h,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 14.w, bottom: 3.h),
                          child: FadeText(
                            text: videoItem!.name!,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 14.w, bottom: 3.h),
                            child: FadeText(
                              text: videoItem!.description!,
                              color: AppColors.primaryFourElementText,
                            )),
                      ],
                    ),
                  ],
                ),
        ));
  }
}
