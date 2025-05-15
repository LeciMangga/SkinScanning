import 'package:get_storage/get_storage.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/scan_history_controller.dart';
import 'package:skinscanning/src/page/ScanUrSkin/widget/scan_history_card.dart';

class ScanHistoryCardlist extends StatefulWidget {
  const ScanHistoryCardlist({super.key});

  @override
  State<ScanHistoryCardlist> createState() => _ScanHistoryCardlistState();
}

class _ScanHistoryCardlistState extends State<ScanHistoryCardlist> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScanHistoryController>();
    return Obx(() => controller.historyFetchLoading.value ?
    Center(child: CircularProgressIndicator(),) :
    Container(
      padding: EdgeInsets.symmetric(vertical: 0.5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: controller.isSortedDsc.value ?
          controller.scanHistoryModelList.reversed.map((model) {
            return ScanHistoryCard(scanHistoryModel: model);
          }).toList() :
          List.generate(controller.scanHistoryModelList.length, (index){
            return ScanHistoryCard(scanHistoryModel: controller.scanHistoryModelList[index],);
          })
      ),
    ));
  }
}
