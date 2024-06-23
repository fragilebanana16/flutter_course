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
    return Container(
        child: SafeArea(
      child: Scaffold(
          body: appScreens(index: curIndex),
          bottomNavigationBar: Container(
            width: 375.w,
            height: 68.h,
            decoration: appBoxShadowWithRadius(),
            child: Container(
              decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  offset: Offset(0, -3),
                )
              ]),
              child: BottomNavigationBar(
                backgroundColor: TColor.bg,
                currentIndex: curIndex,
                onTap: (value) {
                  ref
                      .read(applicationNavIndexProvider.notifier)
                      .changeIndex(value);
                },
                elevation: 0,
                items: bottomTabs,
                unselectedItemColor: TColor.lightGray,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          )),
    ));
  }
}
