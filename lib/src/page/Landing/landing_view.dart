import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/FYI_controller.dart';
import 'package:skinscanning/src/page/Landing/landing_controller.dart';
import 'package:skinscanning/src/page/Landing/widget/landing_news_list.dart';
import 'package:skinscanning/src/page/Landing/widget/search_bar.dart';
import 'package:skinscanning/src/page/Landing/widget/scan_your_skin_card.dart';
import 'package:skinscanning/src/page/Landing/widget/skin_info_list.dart';

import '../News/news_controller.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late NewsController controller;
  late FyiController controllerFYI;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NewsController());
    controllerFYI = Get.put(FyiController());
  }

  @override
  void dispose() {
    Get.delete<NewsController>();
    Get.delete<FyiController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingController>(
      init: LandingController(),
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.onTapGestureDetector(context);
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox( height: 30),
              const SearchingBar(),
              const SizedBox(height: 20),
              ScanYourSkinCard(
                onTap: controller.goToScanPage,
              ),
              const SizedBox(height: 20),
              const SkinInfoList(),
              const LandingNewsList(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
