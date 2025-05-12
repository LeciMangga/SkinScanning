import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Register/register_controller.dart';
import 'package:skinscanning/src/page/Register/widget/register_with_email_and_password_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controlller) => SafeArea(
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
                  registerEmailPassword(),
                ],
              ),
            ),
          )
      ),
    );
  }
}
