import 'package:skinscanning/src/core/base_import.dart';

class LandingController extends BaseController with GetSingleTickerProviderStateMixin{
  final searchFormKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  late FocusNode focusNode ;


  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
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