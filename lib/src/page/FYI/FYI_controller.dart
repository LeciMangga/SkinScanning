  import 'package:skinscanning/src/core/base_import.dart';
  import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';
  import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart';

  import 'models/FYI_model.dart';
  import 'models/FYI_service.dart';

  class FyiController extends BaseController with GetSingleTickerProviderStateMixin{
    late FocusNode focusNode;
    late final FyiService _fyiService;
    RxList<FyiModel> fyiItems = <FyiModel>[].obs;
    RxString errorMessage = ''.obs;


    void onTapGestureDetector(BuildContext context){
      FocusScope.of(context).unfocus();
    }

    void goToScanPage() {
      final controller = Get.find<BaseBuilderController>();
      controller.selectedIndex.value = 4;
      controller.builded.value = ScanurskinView();
    }

    @override
    void onInit() {
      super.onInit();
      _fyiService = Get.put(FyiService());
      focusNode = FocusNode();
      fetchFyiItems();
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

    Future<void> fetchFyiItems() async {
      try {
        final items = await _fyiService.getAllFyiItems();
        fyiItems.assignAll(items); // Use assignAll for efficient update
        if(fyiItems.isEmpty){
          errorMessage.value = "No FYI items found.";
        }
      } catch (e) {
        print("Error fetching FYI items: $e");
        errorMessage.value = 'Failed to load FYI items: $e'; // Set error message
      }
    }

  }