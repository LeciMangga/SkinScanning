import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';
import 'package:skinscanning/src/page/Template/base_appBar.dart';
import 'package:skinscanning/src/page/Template/base_bottom_navbar.dart';
import 'package:animations/animations.dart';

class BaseBuilder extends StatefulWidget {
  const BaseBuilder({super.key});

  @override
  State<BaseBuilder> createState() => _BaseBuilderState();
}

class _BaseBuilderState extends State<BaseBuilder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseBuilderController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppbar(),
        bottomNavigationBar: BaseBottomNavbar(),
        body: Obx(() => controller.buildPageTransitionSwitcher(),
      ),
    ));
  }


}
