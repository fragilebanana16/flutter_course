import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/home/controller/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // all
        Container(
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text16Normal(
                    text: "Select you dishes", fontWeight: FontWeight.bold),
                GestureDetector(
                  child: const Text10Normal(
                      text: "All",
                      color: AppColors.primaryThirdElementText,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),

        SizedBox(
          height: 14.h,
        ),
        // button
        Container(
            child: Row(
          children: [
            Container(
              decoration:
                  appBoxShadow(color: AppColors.primaryElement, radius: 6.w),
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
              child: const Text11Normal(text: "All"),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const Text11Normal(
                text: "Pop",
                color: AppColors.primaryThirdElementText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const Text11Normal(
                text: "Music",
                color: AppColors.primaryThirdElementText,
              ),
            ),
          ],
        ))
      ],
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: Global.storageService.getUserProfile().userName!,
          fontWeight: FontWeight.bold),
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: "Damn",
          color: AppColors.primaryThirdElementText,
          fontWeight: FontWeight.bold),
    );
  }
}

class HomeBanner extends StatelessWidget {
  final PageController controller;
  final WidgetRef ref;

  const HomeBanner({super.key, required this.controller, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // banners
        SizedBox(
          width: 325.w,
          height: 160.h,
          child: PageView(
            controller: controller,
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

AppBar homeAppBar() {
  return AppBar(
    backgroundColor: Colors.green,
    leading: Container(), // arrow back
    leadingWidth: 0,

    title: Container(
      color: Colors.red,
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        appImage(icon: Icons.menu, size: 20.w),
        GestureDetector(
          child: AppBoxDecoration(
              width: 40.w, height: 40.w, imagePath: ImageRes.welcomePage1),
        ),
      ]),
    ),
  );
}
