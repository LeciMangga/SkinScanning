import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ForgotPassword/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(ForgotPasswordController());
  }
}