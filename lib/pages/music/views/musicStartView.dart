import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/StepViewModel.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicStartView extends StatefulWidget {
  const MusicStartView({super.key});

  @override
  State<MusicStartView> createState() => _SplashViewState();
}

class _SplashViewState extends State<MusicStartView> {
  final splashVM = Get.put(StartViewModel());
  final stepVM = Get.put(StepViewModel());
  bool _navigatedByButton = false;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndStart();
    // 如果不是点击按钮跳转，自动跳转
    Future.delayed(const Duration(seconds: 2), () {
      if (!_navigatedByButton) {
        splashVM.loadView();
      }
    });
  }

  Future<void> _requestPermissionAndStart() async {
    if (await Permission.activityRecognition.request().isGranted) {
      stepVM.startTracking();
    } else {
      print("未授予运动权限");
    }
  }

  void _navigateToMusicApp() {
    _navigatedByButton = true;
    splashVM.loadView();
  }

  void _confirmClearData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("确认清除？"),
        content: const Text("是否清除当前步数、距离和状态？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              stepVM.clearData();
              Navigator.pop(context);
            },
            child: const Text("清除", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Obx(() => Text(
                    "步数：${stepVM.steps.value}",
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              const SizedBox(height: 12),
              Obx(() => Text(
                    "距离：${stepVM.distanceKm.value.toStringAsFixed(2)} 公里",
                    style: const TextStyle(fontSize: 24, color: Colors.white70),
                  )),
              const SizedBox(height: 12),
              Obx(() => Text(
                    "状态：${stepVM.status.value}",
                    style: const TextStyle(fontSize: 24, color: Colors.white70),
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _confirmClearData,
                child: const Text(
                  "清除数据",
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00C853),
                      Color.fromARGB(255, 134, 173, 136)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _navigateToMusicApp,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_run,
                            color: Colors.white, size: 26),
                        SizedBox(width: 10),
                        Text(
                          "Let's Roll",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
