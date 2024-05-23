import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/routes/app_routes_names.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/application/application.dart';
import 'package:flutter_course/pages/home/view/home.dart';
import 'package:flutter_course/pages/signin/sign_in.dart';
import 'package:flutter_course/pages/register/register.dart';
import 'package:flutter_course/pages/welcome/welcome.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path: AppRoutesNames.WELCOME, page: Welcome()),
      RouteEntity(path: AppRoutesNames.SIGN_IN, page: const SignIn()),
      RouteEntity(path: AppRoutesNames.REGISTER, page: const Register()),
      RouteEntity(path: AppRoutesNames.APPLICATION, page: const Application()),
      RouteEntity(path: AppRoutesNames.Home, page: const Home()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print("Current route is ${settings.name}");
    }

    if (settings.name != null) {
      var res = routes().where((element) => element.path == settings.name);
      if (res.isNotEmpty) {
        bool firstTimeOpened = Global.storageService.isFirstOpened();
        if (res.first.path == AppRoutesNames.WELCOME && firstTimeOpened) {
          bool isLoggedIn = Global.storageService.isLoggedIn();
          if (isLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => Application(), settings: settings);
          } else {
            return MaterialPageRoute(
                builder: (_) => SignIn(), settings: settings);
          }
        } else {
          if (kDebugMode) {
            print("first time run");
          }

          return MaterialPageRoute(
              builder: (_) => res.first.page, settings: settings);
        }
      }
    }

    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Container(),
            ),
        settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
