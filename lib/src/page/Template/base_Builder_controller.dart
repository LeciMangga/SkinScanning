import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/landing_view.dart';
import 'package:skinscanning/src/page/News/news_view.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart';

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

  Rx<Widget> builded = Rx<Widget>(LandingView());

  void onTapNavBar(int index){
    selectedIndex.value = index;
    switch (index){
      case 0:
        builded.value = LandingView();
        break;
      case 1:
        builded.value = Placeholder();
        break;
      case 2:
        builded.value = ScanurskinView();
        break;
      case 3:
        builded.value = NewsView();
        break;
      case 4:
        builded.value = Placeholder();
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