import 'package:flutter/material.dart';
import 'package:flutter_course/pages/music/views/musicAppTab.dart';
import 'package:get/get.dart';

class StartViewModel extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void loadView() async {
    await Future.delayed(const Duration(milliseconds: 200));
    Get.to(() => const MusicApp(), arguments: {'fromButtonRoll': true});
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
