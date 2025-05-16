import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:skinscanning/src/core/base_import.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinscanning/src/page/ScanUrSkin/models/scan_history_service.dart';
import 'package:skinscanning/src/page/ScanUrSkin/scan_history_view.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';
import 'package:image/image.dart' as img;


class ScanurskinController extends BaseController with GetSingleTickerProviderStateMixin{

  late FocusNode focusNode;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  DateTime? lastSendTime;

  RxBool isLoadingDiseaseName = false.obs;

  late final ScanHistoryService scanHistoryService;

  var diseaseName = Rxn<String>();
  var diseaseScore = Rxn<String>();

  Rx<CameraController?> controllerCam = Rx<CameraController?>(null);
  RxInt camIndex = 0.obs;
  late List<CameraDescription>? cameras;
  RxBool isCameraInit = false.obs;

  Uint8List? jpegBytes;
  Uint8List? imageDetectedbytes;

  Future<void> onTapGetDiseaseName()async{
    Future.delayed(Duration(milliseconds: 500));
    getDiseaseName(jpegBytes!);
  }

  Future<void> getDiseaseName(Uint8List jpegBytes) async{
    isLoadingDiseaseName.value = true;
    try{
      String base64image = base64Encode(jpegBytes);
      final url = Uri.parse("https://skin-disease-predictor-1061602829360.us-central1.run.app/predict");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "instances": [
            {
              "image_bytes": base64image
            }
          ]
        })
      );
      String? diseasename;
      double? confidence_score;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prediction = data['predictions'][0];

        diseasename = prediction['predicted_condition'];
        confidence_score = prediction['confidence'];
        print("Detected disease: $diseasename");
      } else {
        print("Failed to get disease. Status code: ${response.statusCode}");
        print("Body: ${response.body}");
      }
      final score = confidence_score ?? 0;
      diseaseName.value = score < 0.6 ? "Healthy"  :  "$diseasename" ?? "Unknown";
      diseaseScore.value = (score*100).toStringAsFixed(2);
      imageDetectedbytes = jpegBytes;
      print(diseaseName.value);
      print("confidence Score = ${score}");
    } catch (e){
      print("error getDiseaseName : $e");
    }
    isLoadingDiseaseName.value = false;
  }

  Future<void> initCamera() async{
    await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
    ].request();
    cameras = await availableCameras();

    controllerCam.value = CameraController(
      cameras![camIndex.value],
      ResolutionPreset.medium,
    );

    try {
      await controllerCam.value?.initialize();
      isCameraInit.value = true;
      controllerCam.value?.startImageStream(
              (CameraImage image){
            processCameraImage(image);
          }
      );
    } catch (e) {
      print("Camera init error: $e");
    }
  }

  Future<void> changeCamera() async {
    try {
      isCameraInit.value = false;
      await controllerCam.value?.dispose();

      camIndex.value = camIndex.value == 0 ? 1 : 0;
      controllerCam.value = CameraController(
        cameras![camIndex.value],
        ResolutionPreset.medium,
      );

      await controllerCam.value?.initialize();


      await initCamera();

      isCameraInit.value = true;
    } catch (e) {
      print("Error switching camera: $e");
    }
  }


  Future<void> onTapSave()async{
    if (imageDetectedbytes != null){
      await scanHistoryService.saveScanHistory(imageDetectedbytes!, diseaseName.value, diseaseScore.value);
    } else {
      print("JPEG is null. Make sure an image has been captured.");
    }
    onTapHistory();
  }

  void processCameraImage(CameraImage image) {
    final now = DateTime.now();

    if (lastSendTime == null || now.difference(lastSendTime!).inMilliseconds > 1500) {
      lastSendTime = now;

      jpegBytes = convertYUV420ToJPEG(image);
      if (camIndex.value == 0) {
        jpegBytes = rotateImage(jpegBytes!, 90);
      } else if (camIndex.value == 1){
        jpegBytes = rotateImage(jpegBytes!, -90);
      }
    }
  }

  Uint8List rotateImage(Uint8List jpegBytes, int angle) {
    final original = img.decodeImage(jpegBytes);
    if (original == null) return jpegBytes;

    final rotated = img.copyRotate(original, angle: angle);
    return Uint8List.fromList(img.encodeJpg(rotated));
  }

  Uint8List convertYUV420ToJPEG(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    // Get planes
    final yPlane = cameraImage.planes[0].bytes;
    final uPlane = cameraImage.planes[1].bytes;
    final vPlane = cameraImage.planes[2].bytes;

    // Create an empty Image buffer from 'image' package
    final imgImage = img.Image(width: width, height: height);

    // Convert YUV420 to RGB
    int uvRowStride = cameraImage.planes[1].bytesPerRow;
    int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yp = y * cameraImage.planes[0].bytesPerRow + x;
        final up = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;
        final vp = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;

        int Y = yPlane[yp];
        int U = uPlane[up];
        int V = vPlane[vp];

        // YUV to RGB conversion (ITU-R BT.601)
        int r = (Y + (1.370705 * (V - 128))).round();
        int g = (Y - (0.337633 * (U - 128)) - (0.698001 * (V - 128))).round();
        int b = (Y + (1.732446 * (U - 128))).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        imgImage.setPixelRgb(x, y, r, g, b);
      }
    }

    // Encode to JPEG
    final jpeg = img.encodeJpg(imgImage, quality: 75); // quality 75%

    return Uint8List.fromList(jpeg);
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
      print('Picked image path: ${pickedFile.path}');
      image = pickedFile;
      Uint8List imageBytes = await pickedFile.readAsBytes();
      print('image converted to bytes : ${imageBytes}');
      getDiseaseName(imageBytes);
      await scanHistoryService.saveScanHistory(imageBytes, diseaseName.value, diseaseScore.value);
      onTapHistory();
    }
  }

  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  @override
  Future<void> onInit() async{
    super.onInit();
    focusNode = FocusNode();
    scanHistoryService = Get.put(ScanHistoryService());
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