import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/startup/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(StartupController());
  }
}