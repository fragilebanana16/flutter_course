import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/pages/application/notifier/application_nav_notifier.dart';
import 'package:flutter_course/pages/application/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends ConsumerWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int curIndex = ref.watch(applicationNavIndexProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Container(),
        bottomNavigationBar: Container(
          width: 375.w,
          height: 58.h,
          decoration: appBoxShadowWithRadius(),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: curIndex,
            onTap: (value) {
              ref.read(applicationNavIndexProvider.notifier).changeIndex(value);
            },
            elevation: 0,
            items: bottomTabs,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      )),
    );
  }
}
