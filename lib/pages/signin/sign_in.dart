import 'package:flutter/material.dart';
import 'package:flutter_course/common/global_loader.dart/global_loader.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_textfields.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/signin/notifier/sign_in_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/button_widget.dart';
import 'sign_in_controller.dart';
import 'widgets/sign_in_widgets.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;

  @override
  void initState() {
    _controller = SignInController(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(apploaderProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppBar(title: "Login"),
            backgroundColor: Colors.white,
            body: loader == false
                ? SingleChildScrollView(
                    // avoid keyboard overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        thirdPartyLogin(),
                        Center(
                          child: text14Normal(text: "Select method to log in"),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        // email
                        appTextField(
                            controller: _controller.userNameController,
                            text: "Email",
                            iconName: "assets/icons/user.png",
                            hintText: "email here",
                            func: (value) => ref
                                .read(signInNotifierProvider.notifier)
                                .onUserNameChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        // password
                        appTextField(
                            controller: _controller.passwordController,
                            text: "Password",
                            iconName: "assets/icons/password.png",
                            hintText: "password",
                            obscureText: true,
                            func: (value) => ref
                                .read(signInNotifierProvider.notifier)
                                .onPasswordChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        //forget
                        Container(
                          margin: EdgeInsets.only(left: 25.w),
                          child: textUnderline(text: "Forgot password?"),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        // login
                        Center(
                          child: appButton(
                              buttonName: "Login",
                              isLogin: true,
                              context: context,
                              func: _controller.handleSignIn),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: appButton(
                            buttonName: "Register",
                            context: context,
                            func: () =>
                                Navigator.pushNamed(context, "/register"),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement,
                    ),
                  )),
      ),
    );
  }
}
