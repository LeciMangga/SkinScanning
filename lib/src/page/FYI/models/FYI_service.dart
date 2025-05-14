// lib/app/data/services/fyi_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'FYI_model.dart';

class FyiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'diseases';

  Future<FyiModel?> getFyiItem(String id) async {
    try {
      final docSnapshot = await _firestore.collection(_collection).doc(id).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return FyiModel.fromSnapshot(docSnapshot);
      }
      return null;
    } catch (e) {
      print('Error fetching FYI item: $e');
      return null;
    }
  }

  // Get all FYI items
  Future<List<FyiModel>> getAllFyiItems() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).orderBy('createdAt', descending: true).get();
      print('Fetched ${querySnapshot.docs.length} FYI items');
      return querySnapshot.docs.map((doc) => FyiModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching all FYI items: $e');
      return [];
    }
  }

  // Add a new FYI item
  Future<void> addFyiItem(FyiModel fyiItem) async {
    try {
      await _firestore.collection(_collection).add(fyiItem.toFirestore());
    } catch (e) {
      print('Error adding FYI item: $e');
    }
  }

  // Update an existing FYI item
  Future<void> updateFyiItem(FyiModel fyiItem) async {
    try {
      if (fyiItem.id == null) {
        print('Warning: Cannot update FYI item with a null ID.');
        return;
      }
      await _firestore.collection(_collection).doc(fyiItem.id).update(fyiItem.toFirestore());
    } catch (e) {
      print('Error updating FYI item: $e');
    }
  }

  // Delete an FYI item by its ID
  Future<void> deleteFyiItem(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print('Error deleting FYI item: $e');
    }
  }
}