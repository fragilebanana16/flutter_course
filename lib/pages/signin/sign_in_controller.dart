import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/global_loader.dart/global_loader.dart';
import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/common/services/http_util.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/popup_messages.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/pages/application/application.dart';
import 'package:flutter_course/pages/signin/notifier/sign_in_notifier.dart';
import 'package:flutter_course/pages/signin/repo/sign_in_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SignInController {
  SignInController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.read(signInNotifierProvider);
    String userName = state.userName;
    String password = state.password;
    // remember the text
    userNameController.text = userName;
    passwordController.text = password;

    UserProfile userProfile = UserProfile();
    userProfile.userName = userName;
    userProfile.password = password;

    ref.read(apploaderProvider.notifier).setLoaderValue(true);
    print(userProfile.toJson());

    try {
      var navigator = Navigator.of(ref.context);
      var rsp = await SignInRepo.SignIn(param: userProfile);
      // if rsp 200 code
      if (rsp.statusCode == 200) {
        Global.storageService.setBool(AppConstants.LOGGED_IN, true);
        Global.storageService
            .setString(AppConstants.USER_PROFILE, jsonEncode(rsp.data));
        // Global.storageService
        //     .setString(AppConstants.USER_TOKEN, jsonEncode(userProfile));
        // navigator.push(MaterialPageRoute(
        //     builder: (BuildContext context) => Scaffold(
        //           appBar: AppBar(),
        //           body: const Application(),
        //         )));

        // remove previous routes when met the provided route
        navigator.pushNamedAndRemoveUntil("/application", (route) => false);

        // navKey.currentState
        //     ?.pushNamedAndRemoveUntil("/application", (route) => false);

        // navigator.pushNamed("/application");
      } else {
        toastInfo("[ERR]Login error");
      }
    } catch (e) {
      toastInfo(e.toString());
    }

    // await Future.delayed(const Duration(seconds: 2), () async {});
    ref.read(apploaderProvider.notifier).setLoaderValue(false);
  }
}
