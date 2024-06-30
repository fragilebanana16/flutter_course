// import 'package:file_manager/app/features/dashboard/cloud/views/screens/cloud_screen.dart';
// import 'package:file_manager/app/features/dashboard/home/views/screens/home_screen.dart';
// import 'package:file_manager/app/features/dashboard/index/views/screens/dashboard_screen.dart';
// import 'package:file_manager/app/features/splash/views/screens/splash_screen.dart';
import 'package:flutter_course/pages/fileManage/dashboard/cloud/views/screens/cloud_screen.dart';
import 'package:flutter_course/pages/fileManage/dashboard/home/views/screens/home_screen.dart';
import 'package:flutter_course/pages/fileManage/dashboard/index/views/screens/dashboard_screen.dart';
import 'package:flutter_course/pages/fileManage/file_splash_view.dart';

import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened this page will be the first to be shown
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => FileSplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
        HomeBinding(),
        CloudBinding(),
      ],
    ),
  ];
}
