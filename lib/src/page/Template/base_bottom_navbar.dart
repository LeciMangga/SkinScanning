import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Template/base_Builder.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';

class BaseBottomNavbar extends StatefulWidget {
  const BaseBottomNavbar({super.key});

  @override
  State<BaseBottomNavbar> createState() => _BaseBottomNavbarState();
}

class _BaseBottomNavbarState extends State<BaseBottomNavbar> {

  BaseBuilderController controller = Get.find<BaseBuilderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.selectedIndex.value,
      onTap: controller.onTapNavBar,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      items: List.generate(controller.itemsNavBar.length, (index){
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(controller.itemsNavBar[index]),
          activeIcon: SvgPicture.asset(controller.itemsSelectedNavBar[index]),
          label: controller.labelNavBar[index],
        );
      }),
    ));
  }
}

