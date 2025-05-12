import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/landing_controller.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(LandingController());
  }
}