import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(LoginController());
  }
}