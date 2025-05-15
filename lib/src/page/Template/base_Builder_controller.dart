
import 'package:animations/animations.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_controller.dart';
import 'package:skinscanning/src/page/Forum/forum_view.dart';
import 'package:skinscanning/src/page/Forum/models/forum_service.dart';
import 'package:skinscanning/src/page/FYI/FYI_view.dart';
import 'package:skinscanning/src/page/Landing/landing_view.dart';
import 'package:skinscanning/src/page/News/news_view.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart';

import '../News/models/news_model.dart';
import '../News/news_detail_view.dart';

class BaseBuilderController  extends BaseController with GetSingleTickerProviderStateMixin{

  RxInt selectedIndex = 0.obs;

  final itemsNavBar = [
    'assets/images/home.svg',
    'assets/images/message.svg',
    'assets/images/Scan.svg',
    'assets/images/news.svg',
    'assets/images/FYI.svg'
  ];
  final itemsSelectedNavBar = [
    'assets/images/home_selected.svg',
    'assets/images/message_selected.svg',
    'assets/images/scan_selected.svg',
    'assets/images/news_selected.svg',
    'assets/images/FYI_selected.svg'
  ];
  final labelNavBar = [
    'Home',
    'Discuss',
    'Scan Now',
    'News',
    'FYI',
  ];

  Rx<Widget> builded = Rx<Widget>(LandingView(key: ValueKey("LandingView")));

  PageTransitionSwitcher buildPageTransitionSwitcher() {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation, secondaryAnimation) =>
          // FadeThroughTransition(
          //   animation: animation,
          //   secondaryAnimation: secondaryAnimation,
          //   child: child,
          // ),
      SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal, // Can be X, Y, or Z
        child: child,
      ),
      child: builded.value,
    );
  }

  void onTapNavBar(int index){
    selectedIndex.value = index;
    switch (index){
      case 0:
        builded.value = LandingView(key: ValueKey("LandingView"));
        break;
      case 1:
        builded.value = ForumView(key: ValueKey("ForumView"));
        break;
      case 2:
        builded.value = ScanurskinView(key: ValueKey("ScanurskinView"));
        break;
      case 3:
        builded.value = NewsView(key: ValueKey("NewsView"));
        break;
      case 4:
        builded.value = FyiView(key: ValueKey("FyiView"));
        break;
    }
  }

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() async {


    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> onWillPop() async {
    return await onGoBack();
  }

  onGoBack() async {
    Get.back();
    return true;
  }
}