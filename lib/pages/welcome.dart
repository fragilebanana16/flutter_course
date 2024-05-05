import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets.dart';

class Welcome extends StatefulWidget {
  Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _controller = PageController();
  int dotIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.only(top: 30.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // welcome pages
                PageView(
                  onPageChanged: (value) {
                    print(value.toString());
                    setState(() {
                      dotIndex = value;
                    });
                  },
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    appOnBoardingPage(_controller,
                        imagePath: "assets/images/reading.png",
                        title: "Learn stack manage",
                        subTitle: "Books, shelf list, all in one page.",
                        index: 1),
                    appOnBoardingPage(_controller,
                        imagePath: "assets/images/music.png",
                        title: "Second music",
                        subTitle:
                            "Music management in one project with flutter",
                        index: 2)
                  ],
                ),
                // dots
                Positioned(
                  bottom: 100,
                  child: DotsIndicator(
                    dotsCount: 2,
                    position: dotIndex,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(24.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w))),
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
