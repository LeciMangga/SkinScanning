import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Login/login_controller.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    return GestureDetector(
      onTap: controller.loginwithGoogle,
      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border(
            top: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black)
          ),
          color: Colors.transparent,
        ),
        child: SvgPicture.asset('assets/images/Google.svg', color: Colors.black),
      ),
    );
  }
}
