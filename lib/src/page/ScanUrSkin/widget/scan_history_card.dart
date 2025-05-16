import 'dart:convert';

import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/models/scan_history_model.dart';
import 'package:intl/intl.dart';
import 'package:skinscanning/src/page/ScanUrSkin/scan_history_controller.dart';

class ScanHistoryCard extends StatelessWidget {
  final ScanHistoryModel scanHistoryModel;

  const ScanHistoryCard({
    super.key,
    required this.scanHistoryModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScanHistoryController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFF808488),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              '${DateFormat('dd-MM-yyyy').format(scanHistoryModel.dateUploaded.toDate())}\n${scanHistoryModel.diseasesName}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16
              ),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  controller.onTapDetailsDiseases(scanHistoryModel.diseasesName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD6D6D6),
                  minimumSize: const Size(70,30),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  maximumSize: const Size(100,30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
                child: Text(
                  'Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                    fontSize: 16
                  ),
                )
              ),
              ElevatedButton(
                  onPressed: (){
                    controller.removeHistory(scanHistoryModel);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE34949),
                      minimumSize: const Size(70,30),
                      maximumSize: const Size(100,30),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),

                      )
                  ),
                  child: Text(
                    'Remove',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                        fontSize: 16
                    ),
                  )
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // Increased border radius
            child: scanHistoryModel.base64image.isNotEmpty
                ? Image.memory(
              base64Decode(scanHistoryModel.base64image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    size: 50, // Increased icon size
                    color: Colors.grey,
                  ),
                );
              },
            )
                : Container(
              width: 150, // Match increased image width
              height: 150, // Match increased image height
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                size: 50, // Increased icon size
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
