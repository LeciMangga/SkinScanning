import 'package:skinscanning/src/core/base_import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/page/Forum/models/forum_model.dart';

class ForumService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ForumModel>> fetchForumsfromFirebase(int limit) async {
    Query<Map<String, dynamic>> query = await _firestore.collection('forums')
        .orderBy('upvote',descending: true)
        .limit(limit);
    try{

      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
      // Log the snapshot to see the raw data returned from Firebase
      print('Fetched data from Firestore: ${snapshot.docs.length} items');
      List<ForumModel> forumList = [];
      for (final doc in snapshot.docs){
        final forumData = doc.data();
        final forumID = doc.id;

        DocumentSnapshot<Map<String, dynamic>> voteSnapshot = await _firestore
            .collection('forums')
            .doc(forumID)
            .collection('votes')
            .doc(Auth.to.GetFireBaseAuth().currentUser!.uid.toString())
            .get();

        bool isUpvoted = false;
        bool isDownvoted = false;

        if (voteSnapshot.exists && voteSnapshot.data() != null){
          final voteData = voteSnapshot.data()!;
          isUpvoted = voteData['isUpvoted'];
          isDownvoted = voteData['isDownvoted'];
        }

        final forumModel = ForumModel.fromMap(forumData, forumID,isUpvoted,isDownvoted);
        forumList.add(forumModel);
      }

      return forumList;
    }catch (e){
      print('Error fetching forums: $e');
      return [];
    }
  }

  Future<void> addForum(ForumModel forum) async {
    await _firestore.collection('forums').add(forum.toMap());
  }

  Future<void> onTapUpvotewithUser(String userId,String username, String id, int updatedUpvote, updatedDownvote, bool isUpvoted) async {
    final docRef = _firestore.collection('forums')
        .doc(id).collection('votes').doc(userId);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        await _firestore.collection('forums').doc(id).update({
          'upvote': updatedUpvote,
          'downvote': updatedDownvote,
          'points': updatedUpvote - updatedDownvote,
        });
        docRef.update({
          'username': username,
          'isUpvoted': isUpvoted,
        });
      } else {
        await _firestore.collection('forums').doc(id).update({
          'upvote': updatedUpvote,
          'downvote': updatedDownvote,
          'points': updatedUpvote - updatedDownvote,
        });
        docRef.set({
          'username': username,
          'isUpvoted': isUpvoted,
        });
      }
    } catch (e){
      Get.snackbar('Error', 'failed fetching');
    }
  }

  Future<void> onTapDownvotewithUser(String userId, String username, String id, int updatedUpvote, updatedDownvote, bool isDownvoted) async {
    final docRef = _firestore.collection('forums')
        .doc(id).collection('votes').doc(userId);
    try {
      final doc = await docRef.get();
      if (doc.exists) {
        await _firestore.collection('forums').doc(id).update({
          'upvote': updatedUpvote,
          'downvote': updatedDownvote,
          'points': updatedUpvote - updatedDownvote,
        });
        docRef.update({
          'username': username,
          'isDownvoted': isDownvoted,
        });
      } else {
        await _firestore.collection('forums').doc(id).update({
          'upvote': updatedUpvote,
          'downvote': updatedDownvote,
          'points': updatedUpvote - updatedDownvote,
        });
        docRef.set({
          'username': username,
          'isDownvoted': isDownvoted,
        });
      }
    } catch (e){
      Get.snackbar('Error', 'failed fetching');
    }
  }

  Future<void> postCommentToFirebase(String comment, ForumModel forumModel)async{
    await _firestore.collection('forums')
        .doc(forumModel.id)
        .collection('comments')
        .add({
      'username': Auth.to.GetFireBaseAuth().currentUser!.displayName,
      'comment': comment
    });
  }

  Future<List<dynamic>> fetchAllComments(ForumModel forumModel) async{
    Query<Map<String, dynamic>> docRef = await _firestore.collection('forums')
        .doc(forumModel.id)
        .collection('comments');
    try{
      QuerySnapshot<Map<String, dynamic>> snapshot = await docRef.get();
      final commentList = [];
      for (final doc in snapshot.docs){
        final data = doc.data();
        final mappedComment = {
          'username': data['username'],
          'comment': data['comment']
        };
        commentList.add(mappedComment);
      }
      return commentList;
    } catch (e){
      print("$e");
      return [];
    }

  }
}
