import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/scan_history_controller.dart';
import 'package:skinscanning/src/page/ScanUrSkin/widget/scan_history_cardlist.dart';

class ScanHistoryView extends StatefulWidget {
  const ScanHistoryView({super.key});

  @override
  State<ScanHistoryView> createState() => _ScanHistoryViewState();
}

class _ScanHistoryViewState extends State<ScanHistoryView> {

  late final ScanHistoryController controller;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ScanHistoryController>()) {
      controller = Get.put(ScanHistoryController());
    }
  }

  @override
  void dispose() {
    Get.delete<ScanHistoryController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTapGestureDetector(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.scanHistoryModelList.length} items',
                  style: TextStyle(
                      color: Color(0xFF808488),
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF3F3F3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Sort',
                            style: TextStyle(
                              color: Color(0xFF808488),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.import_export, color: Color(0xFF808488),)
                        ],
                      ),
                    ),
                    SizedBox(width: 12,),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF3F3F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              color: Color(0xFF808488),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.filter_alt, color: Color(0xFF808488),)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Expanded(child: SingleChildScrollView(child: ScanHistoryCardlist())),
          ],
        ),
      ),
    );
  }
}
