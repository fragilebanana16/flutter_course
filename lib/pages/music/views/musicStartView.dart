import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:get/get.dart';

class MusicStartView extends StatefulWidget {
  const MusicStartView({super.key});

  @override
  State<MusicStartView> createState() => _SplashViewState();
}

class _SplashViewState extends State<MusicStartView> {
  final splashVM = Get.put(StartViewModel());

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    splashVM.loadView();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.bg,
      body: Center(
        child: Image.asset(
          "assets/images/app_logo.png",
          width: media.width * 0.30,
        ),
      ),
    );
  }
}
