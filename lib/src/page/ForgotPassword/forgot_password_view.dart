import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ForgotPassword/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (controller) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: (){},
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 140,),
                    Center(child: SvgPicture.asset('assets/images/Logo.svg')),
                    SizedBox(height: 105,),
                    Text('Enter your email to be sent a reset password link.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,),
                    SizedBox(height: 50,),
                    TextFormField(
                      key: controller.emailResetKey,
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      validator: controller.emailValidator,
                    ),
                    SizedBox(height: 55,),
                    ElevatedButton(
                      onPressed: controller.onPressedResetButton,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 2,
                        maximumSize: const Size(150,40),
                        minimumSize: const Size(150,40)
                      ),
                      child: Text('Reset', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
