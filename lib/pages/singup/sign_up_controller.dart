import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/global_loader.dart/global_loader.dart';
import 'package:flutter_course/common/widgets/popup_messages.dart';
import 'package:flutter_course/pages/singup/notifier/register_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SignUpController {
  late WidgetRef ref;
  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotiferProvider);
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (state.userName.isEmpty || userName.isEmpty) {
      toastInfo("userName empty!");
      return;
    }

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("email empty!");
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      toastInfo("password empty!");
      return;
    }

    if (state.rePassword.isEmpty || rePassword.isEmpty) {
      toastInfo("rePassword empty!");
      return;
    }

    if ((state.password != state.rePassword) || rePassword != password) {
      toastInfo("password not same!");
      return;
    }

    ref.read(apploaderProvider.notifier).setLoaderValue(true);

    var requestBody = {
      "username": userName,
      "password": password,
      "email": email,
      "auth_level": "admin"
    };

    String jsonString = jsonEncode(requestBody);
    try {
      var ctx = Navigator.of(ref.context);
      http.Response res = await http.post(
        Uri.parse('http://192.168.0.107:8080/auth/register'),
        body: jsonString,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (kDebugMode) {
        print(res);
      }

      if (res.statusCode == 200) {
        toastInfo("Success!");
        ctx.pop();
      }
    } catch (e) {
      toastInfo("Err! $e");
    }

    ref.read(apploaderProvider.notifier).setLoaderValue(false);

    // Future.delayed(const Duration(seconds: 2), () async { dosomething });
  }
}
