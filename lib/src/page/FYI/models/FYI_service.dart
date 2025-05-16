// lib/app/page/FYI/models/FYI_service.dart
// (Or lib/app/data/services/fyi_service.dart - adjust imports in controller if changed)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/utils/gemini_service.dart';
import 'FYI_model.dart';

class FyiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'diseases'; // Collection name in Firestore
  final GeminiService _geminiService = GeminiService();

  // Get a single FYI item by its ID
  Future<FyiModel?> getFyiItem(String id) async {
    try {
      final docSnapshot = await _firestore.collection(_collection).doc(id).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        // Ensure the snapshot is cast correctly for the FyiModel.fromSnapshot factory
        return FyiModel.fromSnapshot(docSnapshot as DocumentSnapshot<Map<String, dynamic>>);
      }
      return null; // Document does not exist
    } catch (e) {
      print('Error fetching FYI item with ID $id: $e');
      rethrow; // Rethrow to allow the controller to handle it
    }
  }

  // Get all FYI items, ordered by creation date
  Future<List<FyiModel>> getAllFyiItems() async {
    try {
      final querySnapshot = await _firestore.collection(_collection)
          .orderBy('createdAt', descending: true) // Assuming you have a 'createdAt' field
          .get();
      print('Fetched ${querySnapshot.docs.length} FYI items from Firestore.');
      return querySnapshot.docs
          .map((doc) => FyiModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } catch (e) {
      print('Error fetching all FYI items: $e');
      rethrow; // Rethrow for controller handling
    }
  }

  // Add a new FYI item (primarily for admin or internal use, not detailed here)
  Future<DocumentReference> addFyiItem(FyiModel fyiItem) async {
    try {
      // Ensure createdAt is set, preferably server-side or as Timestamp.now() if not already.
      Map<String, dynamic> data = fyiItem.toFirestore();
      if (fyiItem.createdAt == null) {
        data['createdAt'] = Timestamp.now();
      }
      if (fyiItem.detailsLastFetchedAt == null && (fyiItem.description !=null || fyiItem.symptoms != null || fyiItem.treatment !=null)) {
        data['detailsLastFetchedAt'] = Timestamp.now();
      }
      return await _firestore.collection(_collection).add(data);
    } catch (e) {
      print('Error adding FYI item: $e');
      rethrow;
    }
  }

  // Update an existing FYI item
  Future<void> updateFyiItem(FyiModel fyiItem) async {
    if (fyiItem.id == null) {
      print('Error: Cannot update FYI item with a null ID.');
      throw Exception('FYI item ID is null, cannot update.');
    }
    try {
      await _firestore.collection(_collection).doc(fyiItem.id).update(fyiItem.toFirestore());
    } catch (e) {
      print('Error updating FYI item ${fyiItem.id}: $e');
      rethrow;
    }
  }

  // Delete an FYI item by its ID
  Future<void> deleteFyiItem(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print('Error deleting FYI item $id: $e');
      rethrow;
    }
  }

  // Fetches details from Gemini and caches them in Firestore
  Future<Map<String, String?>> fetchAndCacheDiseaseDetails({
    required String diseaseId,
    required String diseaseTitle,
  }) async {
    try {
      print('Service: Fetching/Caching details for "$diseaseTitle" (ID: $diseaseId) from API.');
      final details = await _geminiService.generateDiseaseDetails(diseaseTitle);

      final docRef = _firestore.collection(_collection).doc(diseaseId);

      Map<String, dynamic> updateData = {
        'description': details['description'],
        'symptoms': details['symptoms'],
        'treatment': details['treatment'],
        'detailsLastFetchedAt': Timestamp.now(), // Update the timestamp
      };

      await docRef.update(updateData);
      print('Service: Successfully updated Firestore for "$diseaseTitle" with new API details.');

      return {
        'description': details['description'],
        'symptoms': details['symptoms'],
        'treatment': details['treatment'],
      };
    } catch (e) {
      print('Service: Error in fetchAndCacheDiseaseDetails for "$diseaseTitle": $e');
      rethrow; // Rethrow for controller handling
    }
  }
}
