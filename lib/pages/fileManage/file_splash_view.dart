library splash;

import 'package:flutter/material.dart';
import 'package:flutter_course/pages/fileManage/config/routes/app_pages.dart';
import 'package:flutter_course/pages/fileManage/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// binding
part './splash_binding.dart';

// controller
part './splash_controller.dart';

class FileSplashScreen extends GetView<SplashController> {
  FileSplashScreen({Key? key}) : super(key: key);
  // final youController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Image.asset(ImageRaster.logo, height: 150),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.signal_wifi_connected_no_internet_4,
                size: 40,
              ),
              label: const Text(
                "Offline",
                textScaleFactor: 2,
              ),
              onPressed: () {
                controller.goToDashboard();
              },
            ),
            Spacer(flex: 1),
            Obx(
              () => Visibility(
                  child: CircularProgressIndicator(),
                  visible: controller.isLoading.value),
            ),
            Spacer(flex: 1),
            // ListTile(
            //   leading: Image.asset(ImageRaster.youtube, height: 70),
            //   title: Text(
            //     "Flutter With Gia",
            //     style: Theme.of(context).textTheme.subtitle1,
            //   ),
            //   subtitle: Text(
            //     "Get More Tutorial",
            //     style: Theme.of(context).textTheme.caption,
            //   ),
            //   onTap: () => controller.goToYoutubeChannel(),
            // )
          ],
        ),
      ),
    );
  }
}
