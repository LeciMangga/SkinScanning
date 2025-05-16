import 'package:cloud_firestore/cloud_firestore.dart';

class ScanHistoryModel{
  final Timestamp dateUploaded;
  final String diseasesName;
  final String base64image;

  ScanHistoryModel({
    required this.dateUploaded,
    required this.diseasesName,
    required this.base64image
  });

  factory ScanHistoryModel.fromMap(Map<String, dynamic> mappedHistory) {
    return ScanHistoryModel(
      dateUploaded: mappedHistory['dateUploaded'],
      diseasesName: mappedHistory['diseasesName'],
      base64image: mappedHistory['jpegBytes']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'dateUploaded': dateUploaded,
      'diseasesName': diseasesName,
      'jpegBytes': base64image
    };
  }


}