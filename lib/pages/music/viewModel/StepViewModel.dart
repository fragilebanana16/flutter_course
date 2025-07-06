import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';

class StepViewModel extends GetxController {
  final steps = 0.obs;
  final status = '未知'.obs;
  final distanceKm = 0.0.obs;
  final durationSeconds = 0.obs;
  final currentTime = ''.obs;
  Timer? _timer;
  bool _hasStarted = false;
  int _initialSteps = 0;
  Future<bool> startTracking() async {
    final completer = Completer<bool>();

    try {
      bool stepDetected = false;
      Pedometer.stepCountStream.listen((event) {
        if (_initialSteps == 0) {
          _initialSteps = event.steps;
        }

        final currentSteps = event.steps - _initialSteps;
        steps.value = currentSteps;
        distanceKm.value = (currentSteps * 0.75) / 1000;

        if (!_hasStarted) {
          _hasStarted = true;
          _startTimer();
        }

        // 第一次收到步数就认为监听成功
        if (!stepDetected) {
          stepDetected = true;
          if (!completer.isCompleted) completer.complete(true);
        }
      }, onError: (e) {
        print("步数监听失败：$e");
        if (!completer.isCompleted) completer.complete(false);
      });

      Pedometer.pedestrianStatusStream.listen((event) {
        status.value = _mapStatus(event.status);
      }, onError: (e) {
        print("状态监听失败：$e");
      });

      // 设置一个超时机制，防止永远等不到步数
      Future.delayed(const Duration(seconds: 5), () {
        if (!completer.isCompleted) completer.complete(false);
      });
    } catch (e) {
      print("设备不支持计步功能：$e");
      completer.complete(false);
    }

    return completer.future;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final suffix = _getDaySuffix(now.day);
      final date = DateFormat('EEE, MMM d').format(now);
      final time = DateFormat('HH:mm:ss').format(now);
      currentTime.value = '$date$suffix, ${now.year}, $time';
    });
  }

  void stopTracking() {
    _timer?.cancel();
    _hasStarted = false;
  }

  void clearData() {
    steps.value = 0;
    status.value = 'Unknown';
    distanceKm.value = 0.0;
    durationSeconds.value = 0;
    stopTracking();
  }

  String get formattedDuration {
    final hours = (durationSeconds.value ~/ 3600).toString().padLeft(2, '0');
    final minutes =
        ((durationSeconds.value % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationSeconds.value % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  String get formattedDate {
    final now = DateTime.now();
    final daySuffix = _getDaySuffix(now.day);
    final datePart = DateFormat('EEE, MMM d').format(now); // e.g. Mon, Jul 8
    final timePart = DateFormat('HH:mm:ss').format(now); // 24小时制时间
    return '$datePart$daySuffix, ${now.year}, $timePart';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'walking':
        return 'Walking';
      case 'stopped':
        return 'Stopped';
      default:
        return 'Unknown';
    }
  }
}
