import 'package:flutter/gestures.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Login/login_controller.dart';

class loginEmailPassword extends StatelessWidget {
  const loginEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
        child: Column(
          children: [
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your Email',
                labelText: 'Email',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0x909090FF),
                ),
              ),
              validator: controller.emailValidator,
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: controller.passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your Password',
                labelText: 'Password',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0x909090FF),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: controller.onTapForgotPassword,
              child: Container(alignment: Alignment.bottomRight,child: Text('Forgot Password?', style: TextStyle(color: Colors.black),textAlign: TextAlign.end,)),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  elevation: 1,
                  maximumSize: const Size(double.infinity, 40),
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: controller.loginwithEmailandPassword,
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

