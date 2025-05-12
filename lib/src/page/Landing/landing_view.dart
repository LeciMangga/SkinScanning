import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/landing_controller.dart';
import 'package:skinscanning/src/page/Landing/widget/search_bar.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingController>(
      builder: (controller) => BaseScaffold(
          body: GestureDetector(
            onTap: (){controller.onTapGestureDetector(context);},
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  SearchingBar(),
                  SizedBox(height: Get.height*2,)
                ],
              ),
            ),
          ),
        ),
    );
  }
}
