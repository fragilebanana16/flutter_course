import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepViewModel extends GetxController {
  final steps = 0.obs;
  final status = '未知'.obs;
  final distanceKm = 0.0.obs;

  void startTracking() {
    Pedometer.stepCountStream.listen((event) {
      print("stepCountStream");
      steps.value = event.steps;
      distanceKm.value = (event.steps * 0.75) / 1000;
    });

    Pedometer.pedestrianStatusStream.listen((event) {
      print("pedestrianStatusStream");
      status.value = _mapStatus(event.status);
    });
  }

  void clearData() {
    steps.value = 0;
    status.value = '未知';
    distanceKm.value = 0.0;
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'walking':
        return '正在行走';
      case 'stopped':
        return '已停止';
      default:
        return '未知';
    }
  }
}
