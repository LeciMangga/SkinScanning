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
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(vertical: 0.5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(controller.scanHistoryModelList.length, (index){
            return ScanHistoryCard(scanHistoryModel: controller.scanHistoryModelList[index],);
          })
      ),
    ));
  }
}
