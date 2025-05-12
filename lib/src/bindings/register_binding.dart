import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(RegisterController());
  }
}