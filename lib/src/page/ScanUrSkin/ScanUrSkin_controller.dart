import 'package:camera/camera.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinscanning/src/page/ScanUrSkin/scan_history_view.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';


class ScanurskinController extends BaseController with GetSingleTickerProviderStateMixin{

  late FocusNode focusNode;
  final ImagePicker picker = ImagePicker();
  XFile? image;


  CameraController? controllerCam;
  List<CameraDescription>? cameras;
  RxBool isCameraInit = false.obs;


  Future<void> initCamera() async{
    await Permission.camera.request();

    cameras = await availableCameras();
    controllerCam = CameraController(cameras![0], ResolutionPreset.medium);

    await controllerCam!.initialize();

    isCameraInit.value = true;
  }

  void onTapHistory(){
    final baseBuilderController = Get.find<BaseBuilderController>();
    baseBuilderController.builded.value = ScanHistoryView();
  }

  Future<void> requestCameraPermission() async{
    var status = await Permission.camera.status;
    if (!status.isGranted){
      await Permission.camera.request();
    }
  }

  Future<void> takePicture() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null){
      image = pickedFile;
      //update UI
    }
  }

  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  @override
  Future<void> onInit() async{
    super.onInit();
    focusNode = FocusNode();
    await requestCameraPermission();
    await initCamera();
  }

  @override
  void dispose(){
    focusNode.dispose();
    super.dispose();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    controllerCam?.dispose();
    focusNode.dispose();
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