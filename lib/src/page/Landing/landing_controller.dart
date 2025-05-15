import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart';

class LandingController extends BaseController with GetSingleTickerProviderStateMixin{
  final searchFormKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  late FocusNode focusNode ;


  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  void goToScanPage() {
    final controller = Get.find<BaseBuilderController>();
    controller.selectedIndex.value = 2;
    controller.builded.value = ScanurskinView(key: ValueKey("ScanurskinView"));
  }

  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
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