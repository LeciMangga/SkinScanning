import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_controller.dart';

class LiveCameraWidget extends StatefulWidget {
  const LiveCameraWidget({super.key});

  @override
  State<LiveCameraWidget> createState() => _LiveCameraWidgetState();
}

class _LiveCameraWidgetState extends State<LiveCameraWidget> {

  late final ScanurskinController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ScanurskinController>();
  }

  @override
  void dispose() {
    controller.controllerCam?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Container(
          height: 425,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: controller.isCameraInit.value ?
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CameraPreview(controller.controllerCam!),
              ) :
              Center(child: CircularProgressIndicator(),)
          ,
        ),
      ],
    ));
  }

}
