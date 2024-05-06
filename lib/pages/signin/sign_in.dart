import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/button_widget.dart';
import 'widgets/sign_in_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppBar(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
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
                      text: "Email",
                      iconName: "assets/icons/user.png",
                      hintText: "email here"),
                  SizedBox(
                    height: 20.h,
                  ),
                  // password
                  appTextField(
                      text: "Password",
                      iconName: "assets/icons/password.png",
                      hintText: "password",
                      obscureText: true),
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
                    child: appButton(buttonName: "Login", isLogin: true),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: appButton(buttonName: "Register"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
