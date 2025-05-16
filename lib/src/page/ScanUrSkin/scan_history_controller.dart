import 'package:get_storage/get_storage.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/models/scan_history_model.dart';
import 'package:skinscanning/src/page/ScanUrSkin/models/scan_history_service.dart';

class ScanHistoryController extends BaseController with GetSingleTickerProviderStateMixin{

  late FocusNode focusNode;
  RxBool historyFetchLoading = true.obs;
  late final ScanHistoryService scanHistoryService;
  RxBool isSortedDsc = true.obs;

  RxList<ScanHistoryModel> scanHistoryModelList = <ScanHistoryModel>[].obs;

  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  void onTapSorting(){
    if (isSortedDsc.value){
      isSortedDsc.value = false;
    } else{
      isSortedDsc.value = true;
    }
  }

  Future<void> fetchHistory() async{
    historyFetchLoading.value = true;
    try{
      List<ScanHistoryModel> fetchedHistory = await scanHistoryService.fetchAllScanHistoryFromFirebase();
      print("fetchNews: Fetched ${fetchedHistory.length} news items");
      scanHistoryModelList.assignAll(fetchedHistory);
    } catch (e){
      print("Error fetching forum: $e");
    }
    historyFetchLoading.value = false;
  }

  Future<void> removeHistory(ScanHistoryModel scanHistoryModel) async{
    scanHistoryService.removeFromHistory(scanHistoryModel);
    fetchHistory();
  }

  @override
  Future<void> onInit() async{
    super.onInit();
    focusNode = FocusNode();
    scanHistoryService = Get.put(ScanHistoryService());
    fetchHistory();
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