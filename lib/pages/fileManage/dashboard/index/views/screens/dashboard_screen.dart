library dashboard;

import 'package:flutter/material.dart';
import 'package:flutter_course/pages/fileManage/constants/app_constants.dart';
import 'package:flutter_course/pages/fileManage/dashboard/cloud/views/screens/cloud_screen.dart';
import 'package:flutter_course/pages/fileManage/dashboard/home/views/screens/home_screen.dart';
import 'package:get/get.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component
part '../components/bottom_navbar.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(CloudController());

    return Scaffold(
      body: PageView(
        controller: controller.page,
        onPageChanged: (index) => controller.onChangedPage(index),
        children: [
          HomeScreen(),
          CloudScreen(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => _BottomNavbar(
          currentIndex: controller.currentIndex.value,
          onSelected: (index) {
            controller.changePage(index);
          },
        ),
      ),
    );
  }
}
