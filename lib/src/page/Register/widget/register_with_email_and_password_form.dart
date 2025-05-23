import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Register/register_controller.dart';

class registerEmailPassword extends StatelessWidget {
  const registerEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();

    return Form(
      key: controller.registerFormKey,
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
              controller: controller.usernameController,
              textInputAction: TextInputAction.next,
              enableSuggestions: true,
              autocorrect: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your Username',
                labelText: 'Username',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0x909090FF),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username required';
                }
                return null;
              },
            ),
            SizedBox(height: 40,),
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
                onPressed: controller.registerWithEmailandPassword,
                child: const Text(
                  'Sign Up',
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

