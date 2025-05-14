import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/ScanUrSkin/models/scan_history_model.dart';

class ScanHistoryService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ScanHistoryModel>> fetchAllScanHistoryFromFirebase() async {
    try {
      final userId = Auth.to.GetFireBaseAuth().currentUser!.uid;
      final userScanHistorySnapshot = await _firestore.collection('scanHistory')
          .doc(userId).get();

      if (userScanHistorySnapshot.exists) {
        final historyList = userScanHistorySnapshot.data()?['history'] as List<dynamic>?;

        if (historyList != null) {
          List<ScanHistoryModel> scanHistoryList = historyList.map((item) {
            return ScanHistoryModel.fromMap(item as Map<String, dynamic>);
          }).toList();

          return scanHistoryList;
        }
      }
      return [];
    } catch (e) {
      print('Error fetching scan history: $e');
      return [];
    }
  }

}