import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/pages/application/notifier/application_nav_notifier.dart';
import 'package:flutter_course/pages/application/widgets/app_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends ConsumerWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int curIndex = ref.watch(applicationNavIndexProvider);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: appScreens(index: curIndex),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.h),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    TColor.bg.withOpacity(0.9),
                    TColor.bg.withOpacity(0.7)
                  ],
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
                  splashFactory: NoSplash.splashFactory, // 去掉水波纹点击效果
                  highlightColor: Colors.transparent, // 去掉高亮
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.h),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15), // 半透明毛玻璃背景
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
                        onTap: (value) {
                          ref
                              .read(applicationNavIndexProvider.notifier)
                              .changeIndex(value);
                        },
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
        ),
      ),
    );
  }
}
