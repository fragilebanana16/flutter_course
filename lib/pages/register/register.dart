import 'package:flutter/material.dart';
import 'package:flutter_course/common/global_loader.dart/global_loader.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_textfields.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/register/notifier/register_notifier.dart';
import 'package:flutter_course/pages/register/register_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/button_widget.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(apploaderProvider);
    final signUpController = RegisterController(ref: ref);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppBar(title: "Sign up"),
            backgroundColor: Colors.white,
            body: loader == false
                ? SingleChildScrollView(
                    // avoid keyboard overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: text14Normal(text: "Register one account"),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        // email
                        appTextField(
                            text: "Username",
                            icon: Icons.person,
                            hintText: "Username here",
                            func: (value) => ref
                                .read(registerNotiferProvider.notifier)
                                .onUserNameChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        // email
                        appTextField(
                            text: "Email",
                            icon: Icons.email,
                            hintText: "email here",
                            func: (value) => ref
                                .read(registerNotiferProvider.notifier)
                                .onUserEmailChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        // password
                        appTextField(
                            text: "Password",
                            icon: Icons.password,
                            hintText: "password",
                            obscureText: true,
                            func: (value) => ref
                                .read(registerNotiferProvider.notifier)
                                .onPasswordChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        // confirm password
                        appTextField(
                            text: "Confirm Password",
                            icon: Icons.password,
                            hintText: "Confirm password",
                            obscureText: true,
                            func: (value) => ref
                                .read(registerNotiferProvider.notifier)
                                .onRePasswordChange(value)),
                        SizedBox(
                          height: 20.h,
                        ),
                        //forget
                        Container(
                          margin: EdgeInsets.only(left: 25.w),
                          child: text14Normal(
                              text:
                                  "By creating an account, you argree our terms."),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: appButton(
                              buttonName: "Register",
                              isLogin: true,
                              context: context,
                              func: signUpController.handleSignUp),
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
