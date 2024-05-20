import 'package:flutter/material.dart';
import 'package:flutter_course/common/global_loader.dart/global_loader.dart';
import 'package:flutter_course/common/widgets/popup_messages.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/application/application.dart';
import 'package:flutter_course/pages/signin/notifier/sign_in_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController {
  late WidgetRef ref;

  SignInController(this.ref);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn() async {
    var state = ref.read(signInNotifierProvider);
    String userName = state.userName;
    String password = state.password;

    // remember the text
    userNameController.text = userName;
    passwordController.text = password;

    SignInEntity signInEntity = SignInEntity();
    signInEntity.userName = userName;
    signInEntity.password = password;
    ref.read(apploaderProvider.notifier).setLoaderValue(true);
    print(signInEntity.toJson());

    try {
      var navigator = Navigator.of(ref.context);
      Global.storageService.setString("", "");

      // navigator.push(MaterialPageRoute(
      //     builder: (BuildContext context) => Scaffold(
      //           appBar: AppBar(),
      //           body: const Application(),
      //         )));

      // remove previous routes when met the provided route
      navigator.pushNamedAndRemoveUntil("/application", (route) => false);

      // navigator.pushNamed("/application");
    } catch (e) {
      toastInfo(e.toString());
    }

    await Future.delayed(const Duration(seconds: 2), () async {});
    ref.read(apploaderProvider.notifier).setLoaderValue(false);
  }
}

class SignInEntity {
  String? userName;
  String? avatar;
  String? email;
  String? password;

  SignInEntity({this.userName, this.avatar, this.email, this.password});

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "avatar": avatar,
        "email": email,
        "password": password,
      };
}
