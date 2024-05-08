import 'package:flutter_course/pages/singup/notifier/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_notifier.g.dart';

@riverpod
class RegisterNotifer extends _$RegisterNotifer {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onUserNameChange(String userName) {
    state = state.copyWith(userName: userName);
  }

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onRePasswordChange(String rePassword) {
    state = state.copyWith(rePassword: rePassword);
  }
}
