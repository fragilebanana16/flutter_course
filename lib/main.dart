import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_styles.dart';
import 'package:flutter_course/pages/signin/sign_in.dart';
import 'package:flutter_course/pages/singup/sign_up.dart';
import 'package:flutter_course/pages/welcome/welcome.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.appThemeData,
        initialRoute: "/",
        routes: {
          "/": (context) => Welcome(),
          "/signIn": (context) => const SignIn(),
          "/register": (context) => SignUp()
        },
        // home: child, // can not use with initialRoute
      ),
    );
  }
}

final appCount = StateProvider<int>((ref) {
  return 1;
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(appCount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Riverpod app"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FloatingActionButton(
          heroTag: "add",
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const SecondPage()))
          },
          tooltip: 'Increment',
          child: const Icon(Icons.arrow_back),
        ),
        FloatingActionButton(
          heroTag: "goback",
          onPressed: () => {ref.read(appCount.notifier).state++},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ]),
    );
  }
}

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(appCount);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            "$count",
            style: TextStyle(fontSize: 30),
          ),
        ));
  }
}
