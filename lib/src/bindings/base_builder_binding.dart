import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';

class BaseBuilderBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(BaseBuilderController());
  }
}