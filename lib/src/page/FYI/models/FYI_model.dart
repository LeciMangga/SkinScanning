// lib/app/data/models/news_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FyiModel {
  final String? id;
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? symptoms;
  final String? treatment;
  final Timestamp? createdAt;

  FyiModel({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.symptoms,
    this.treatment,
    this.createdAt,
  });

  // Factory method to create a NewsModel from a Firestore DocumentSnapshot
  factory FyiModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return FyiModel(
      id: doc.id,
      imageUrl: data?['imageUrl'] as String?,
      title: data?['title'] as String?,
      description: data?['description'] as String?,
      symptoms: data?['symptoms'] as String?,
      treatment: data?['treatment'] as String?,
      createdAt: data?['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'symptoms': symptoms,
      'treatment': treatment,
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }
}