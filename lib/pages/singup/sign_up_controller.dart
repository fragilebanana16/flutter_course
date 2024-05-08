import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/popup_messages.dart';
import 'package:flutter_course/pages/singup/notifier/register_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController {
  late WidgetRef ref;
  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotiferProvider);
    String name = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (state.userName.isEmpty || name.isEmpty) {
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

    try {
      var ctx = Navigator.of(ref.context);
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print(credential);
      }

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);
        toastInfo("Success!");
        ctx.pop();
      }
    } catch (e) {
      toastInfo("Err! $e");
    }
  }
}
