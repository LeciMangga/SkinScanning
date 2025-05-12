import 'package:flutter/gestures.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Login/login_controller.dart';
import 'package:skinscanning/src/page/Login/widget/login_with_email_password_form.dart';
import 'package:skinscanning/src/page/Login/widget/login_with_google.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.2,),
                SvgPicture.asset('assets/images/Logo.svg',),
                SizedBox(height: Get.height*0.1,),
                loginEmailPassword(),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                          endIndent: Get.width * 0.02,
                        ),
                      ),
                      Text(
                        'or sign in with',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: Get.width * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                LoginWithGoogle(),
                SizedBox(height: 30,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.blue),
                        recognizer:TapGestureRecognizer()..onTap = controller.onTapSignUp,
                      )
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


