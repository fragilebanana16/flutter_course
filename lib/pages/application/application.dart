import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/pages/application/notifier/application_nav_notifier.dart';
import 'package:flutter_course/pages/application/widgets/app_widgets.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Application extends ConsumerWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int curIndex = ref.watch(applicationNavIndexProvider);
    const floatBtnOffset = 110.0;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: appScreens(index: curIndex),
        bottomNavigationBar: FrostedBottomNavigationBar(
          curIndex: curIndex,
          onTap: (value) {
            ref.read(applicationNavIndexProvider.notifier).changeIndex(value);
          },
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(
                left: 28, top: floatBtnOffset), // 调整值，会左上偏移
            child: SnapFloatingBall(floatBtnOffset)),
      ),
    );
  }
}

class SnapFloatingBall extends StatefulWidget {
  final double offset;

  const SnapFloatingBall(this.offset, {Key? key}) : super(key: key);

  @override
  _SnapFloatingBallState createState() => _SnapFloatingBallState();
}

class _SnapFloatingBallState extends State<SnapFloatingBall> {
  double dx = 100;
  double dy = 300;
  final double ballSize = 60.0;
  bool isOutOfBounds = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final musicVM = Get.put(StartViewModel());
    return Stack(
      children: [
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   color: Colors.yellow.withOpacity(0.2), // 高亮背景色
        // ),
        AnimatedPositioned(
          duration: isOutOfBounds ? Duration.zero : Duration(milliseconds: 300),
          curve: Curves.easeOut,
          left: dx,
          top: dy,
          child: GestureDetector(
            onTap: () {
              musicVM.loadView();
            },
            onPanUpdate: (details) {
              setState(() {
                dx = (dx + details.delta.dx)
                    .clamp(0.0, screenSize.width - ballSize * 3 / 2);
                dy = (dy + details.delta.dy).clamp(
                  0,
                  screenSize.height - ballSize * 3 / 2 - widget.offset - 4,
                );
              });
            },
            onPanEnd: (_) {
              double targetDx = dx < screenSize.width / 2
                  ? 0
                  : screenSize.width - ballSize * 3 / 2;
              setState(() {
                dx = targetDx;
              });
            },
            child: Container(
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
                boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
              ),
              child: Icon(Icons.music_note, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

class FrostedBottomNavigationBar extends ConsumerWidget {
  final int curIndex;
  final void Function(int) onTap;

  const FrostedBottomNavigationBar({
    Key? key,
    required this.curIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [TColor.bg.withOpacity(0.9), TColor.bg.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.h),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: curIndex,
                    onTap: onTap,
                    items: bottomTabs,
                    selectedItemColor: Colors.black45,
                    unselectedItemColor: Colors.white70,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
