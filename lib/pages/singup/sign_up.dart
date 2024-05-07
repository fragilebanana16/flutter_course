import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_textfields.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/button_widget.dart';
import '../signin/widgets/sign_in_widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
                      iconName: "assets/icons/user.png",
                      hintText: "Username here"),
                  SizedBox(
                    height: 20.h,
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
                  // confirm password
                  appTextField(
                      text: "Confirm Password",
                      iconName: "assets/icons/password.png",
                      hintText: "Confirm password",
                      obscureText: true),
                  SizedBox(
                    height: 20.h,
                  ),
                  //forget
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: text14Normal(
                        text: "By creating an account, you argree our terms."),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: appButton(
                        buttonName: "Register",
                        isLogin: true,
                        context: context),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
