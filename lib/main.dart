import 'package:flutter/material.dart';
import 'package:flutter_course/common/routes/routes.dart';
import 'package:flutter_course/common/utils/app_styles.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/application/application.dart';
import 'package:flutter_course/pages/music/audio_helpers/page_manager.dart';
import 'package:flutter_course/pages/music/audio_helpers/service_locator.dart';
import 'package:flutter_course/pages/signin/sign_in.dart';
import 'package:flutter_course/pages/register/register.dart';
import 'package:flutter_course/pages/welcome/welcome.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Global.init();
  await setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  getIt<PageManager>().init(); // how to dispose ?
  runApp(const ProviderScope(child: MyApp()));
}

var routesMap = {
  "/": (context) => Welcome(),
  "/signIn": (context) => const SignIn(),
  "/register": (context) => const Register(),
  "/application": (context) => const Application()
};

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    super.dispose();
    getIt<PageManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        navigatorKey: navKey,
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.appThemeData,
        initialRoute: "/",
        // routes: routesMap,
        onGenerateRoute: AppPages.generateRouteSettings,

        // home: child, // can not use with initialRoute
      ),
    );
  }
}

final appCount = StateProvider<int>((ref) {
  return 1;
});
