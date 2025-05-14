// lib/app/page/FYI/models/FYI_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FyiModel {
  final String? id;
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? symptoms;
  final String? treatment;
  final Timestamp? createdAt; // Original creation of the FYI entry
  final Timestamp? detailsLastFetchedAt; // When details were last fetched from API

  FyiModel({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.symptoms,
    this.treatment,
    this.createdAt,
    this.detailsLastFetchedAt,
  });

  // Factory method to create an FyiModel from a Firestore DocumentSnapshot
  factory FyiModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      // Handle the case where data is null, perhaps by returning a default FyiModel or throwing an error.
      // For now, let's assume data is always present if doc.exists is true,
      // but robust code might need more handling here.
      // This primarily guards against doc.data() being null when doc itself exists.
      throw Exception("Document data was null for FyiModel.fromSnapshot with id: ${doc.id}");
    }
    return FyiModel(
      id: doc.id,
      imageUrl: data['imageUrl'] as String?,
      title: data['title'] as String?,
      description: data['description'] as String?,
      symptoms: data['symptoms'] as String?,
      treatment: data['treatment'] as String?,
      createdAt: data['createdAt'] as Timestamp?,
      detailsLastFetchedAt: data['detailsLastFetchedAt'] as Timestamp?,
    );
  }

  // Method to convert an FyiModel instance to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      // Only include fields if they are not null to avoid overwriting with null
      // if that's not intended. Firestore handles nulls, but this can be cleaner.
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (symptoms != null) 'symptoms': symptoms,
      if (treatment != null) 'treatment': treatment,
      // createdAt is typically set on creation.
      // If updating, you usually don't change createdAt from the client.
      // If it's null here, it means it wasn't set or fetched.
      // For new items, it can be set to FieldValue.serverTimestamp() or Timestamp.now().
      // Let's assume if it's present, we preserve it.
      if (createdAt != null) 'createdAt': createdAt,
      if (detailsLastFetchedAt != null) 'detailsLastFetchedAt': detailsLastFetchedAt,
    };
  }

  // Helper method to create a new instance with updated fields (immutable pattern)
  FyiModel copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
    String? symptoms,
    String? treatment,
    Timestamp? createdAt,
    Timestamp? detailsLastFetchedAt,
    bool forceNullDescription = false, // Flags to explicitly set fields to null
    bool forceNullSymptoms = false,
    bool forceNullTreatment = false,
  }) {
    return FyiModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: forceNullDescription ? null : description ?? this.description,
      symptoms: forceNullSymptoms ? null : symptoms ?? this.symptoms,
      treatment: forceNullTreatment ? null : treatment ?? this.treatment,
      createdAt: createdAt ?? this.createdAt,
      detailsLastFetchedAt: detailsLastFetchedAt ?? this.detailsLastFetchedAt,
    );
  }
}
