import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/pages/application/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Container(),
        bottomNavigationBar: Container(
          width: 375.w,
          height: 58.h,
          decoration: appBoxShadowWithRadius(),
          child: BottomNavigationBar(elevation: 0, items: bottomTabs),
        ),
      )),
    );
  }
}
