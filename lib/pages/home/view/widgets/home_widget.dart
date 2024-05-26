import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/home/controller/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget userName() {
  return Container(
    child: text24Normal(
        text: Global.storageService.getUserProfile().userName!,
        fontWeight: FontWeight.bold),
  );
}

Widget helloText() {
  return Container(
    child: text24Normal(
        text: "Damn",
        color: AppColors.primaryThreeElementText,
        fontWeight: FontWeight.bold),
  );
}

Widget banner({required WidgetRef ref}) {
  return Column(
    children: [
      // banners
      SizedBox(
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (index) {
            ref.read(homeScreenBannerDotsProvider.notifier).setIndex(index);
          },
          children: [
            bannerContainer(imagePath: ImageRes.homeBanner1),
            bannerContainer(imagePath: ImageRes.homeBanner2),
            bannerContainer(imagePath: ImageRes.homeBanner3),
          ],
        ),
      ),
      SizedBox(
        height: 5.h,
      ),
      // dots
      DotsIndicator(
        position: ref.watch(homeScreenBannerDotsProvider),
        dotsCount: 3,
        mainAxisAlignment: MainAxisAlignment.center,
        decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(24.0, 8.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w))),
      )
    ],
  );
}

Widget bannerContainer({required String imagePath}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
  );
}