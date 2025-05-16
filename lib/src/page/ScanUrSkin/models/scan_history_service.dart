import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/models/FYI_model.dart';
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

  Future<void> saveScanHistory(Uint8List jpegbytes, String? diseaseName, String? diseaseScore) async{
    try{
      final userId = Auth.to.GetFireBaseAuth().currentUser!.uid;
      final userDoc = _firestore.collection('scanHistory')
          .doc(userId);
      final jpegBase64 = base64Encode(jpegbytes);
      final newHistory = {
        "dateUploaded": Timestamp.now(),
        "diseasesName": diseaseName ?? "Unknown",
        "jpegBytes": jpegBase64,
      };
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        await userDoc.update({
          "history": FieldValue.arrayUnion([newHistory])
        });
      } else {
        await userDoc.set({
          "history": [newHistory]
        });
      }
      print('success saving to firebase');
    } catch (e){
      print('Error saving to firebase $e');
    }
  }

  Future<void> removeFromHistory(ScanHistoryModel scanHistorytoRemove) async{
    try{
      final userId = Auth.to.GetFireBaseAuth().currentUser!.uid;
      final userDoc = _firestore.collection('scanHistory').doc(userId);

      final mapHistorytoRemove = {
        "dateUploaded": scanHistorytoRemove.dateUploaded,
        "diseasesName": scanHistorytoRemove.diseasesName,
        "jpegBytes": scanHistorytoRemove.base64image
      };

      await userDoc.update({
        "history": FieldValue.arrayRemove([mapHistorytoRemove])
      });

      print("Scan History item removed succesfully");
    } catch (e){
      print(e);
    }
  }

  Future<FyiModel> addFyiItem(String diseaseName) async {
    final fyiItem = FyiModel(title: diseaseName);
    try {
      final querySnapshot = await _firestore
          .collection("diseases")
          .where("title", isEqualTo: diseaseName)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Disease already exists
        final doc = querySnapshot.docs.first;
        return FyiModel.fromSnapshot(doc);
      } else {
        final fyiItem = FyiModel(
          title: diseaseName,
          createdAt: Timestamp.now(),
        );

        Map<String, dynamic> data = fyiItem.toFirestore();

        final docRef = await _firestore.collection("diseases").add(data);

        return fyiItem.copyWith(id: docRef.id);
      }
    } catch (e) {
      print('Error adding FYI item: $e');
      rethrow;
    }
  }

}