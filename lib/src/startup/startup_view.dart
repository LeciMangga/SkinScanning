import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/startup/startup_controller.dart';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartupController>(
        init: StartupController(),
        builder: (controller) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Center(
                    child: controller.isLoading ?
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Logo.svg',
                        ),
                        SizedBox(height: 25,),
                        Text(
                          'Examines your skin',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 15,),
                        CircularProgressIndicator()
                      ],
                    ) :
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Logo.svg',
                          ),
                          SizedBox(height: 25,),
                          Text(
                            'Examines your skin',
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Get.height * 3 / 100,
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        'Skin Scanning 2025\nPowered by Google',
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontWeight: FontWeight.w800
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}