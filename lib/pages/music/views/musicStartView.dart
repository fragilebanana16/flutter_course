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
    // splashVM.loadView();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: TColor.bg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.signal_wifi_connected_no_internet_4,
                    size: 40,
                  ),
                  label: const Text(
                    "Offline",
                    textScaleFactor: 2,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.wifi_tethering,
                      size: 40,
                    ),
                    label: const Text(
                      "Online",
                      textScaleFactor: 2,
                    ),
                    onPressed: () {
                      splashVM.loadView();
                    },
                  )),
            ],
          ),
        ));
  }
}
