import 'package:flutter/material.dart';
import 'package:flutter_course/pages/music/views/musicAppTab.dart';
import 'package:get/get.dart';

class StartViewModel extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void loadView({bool fromButtonRoll = false}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    Get.to(
      () => const MusicApp(),
      arguments: {'fromButtonRoll': fromButtonRoll},
      transition: Transition.fade, // 内置动画类型
      duration: Duration(milliseconds: 400), // 动画时长
    );
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
