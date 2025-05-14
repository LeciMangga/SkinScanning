import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/core/base_import.dart';

class ScanHistoryModel{
  final Timestamp dateUploaded;
  final String diseasesName;
  final String imagePath;

  ScanHistoryModel({
    required this.dateUploaded,
    required this.diseasesName,
    required this.imagePath
  });

  factory ScanHistoryModel.fromMap(Map<String, dynamic> mappedHistory) {
    return ScanHistoryModel(
      dateUploaded: mappedHistory['dateUploaded'],
      diseasesName: mappedHistory['diseasesName'],
      imagePath: mappedHistory['imagePath']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'dateUploaded': dateUploaded,
      'diseasesName': diseasesName,
      'imagePath': imagePath
    };
  }


}