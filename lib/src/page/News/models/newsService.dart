import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'news_model.dart'; // Adjust import path

class NewsService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'news';

  Future<List<NewsModel>> getNews(List<String> selectedTags) async {
    Query<Map<String, dynamic>> query = _firestore.collection(_collectionName).orderBy('timestamp', descending: true);

    if (selectedTags.isNotEmpty) {
      query = query.where('tag', whereIn: selectedTags);
    }
    else{
      print("Fetching all news");
    }

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromSnapshot(doc);
      }).toList();
      return newsList;
    } catch (e) {
      return []; // Handle the error appropriately
    }
  }

  Stream<List<NewsModel>> getNewsStream(List<String> selectedTags) {
    Query<Map<String, dynamic>> query = _firestore.collection(_collectionName).orderBy('timestamp', descending: true);

    if (selectedTags.isNotEmpty) {
      query = query.where('tag', whereIn: selectedTags);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => NewsModel.fromSnapshot(doc)).toList();
    });
  }
}
