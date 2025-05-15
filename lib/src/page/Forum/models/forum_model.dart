import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/models/forum_service.dart';

class ForumModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String content;
  RxInt upvote;
  RxInt downvote;
  int points;
  RxBool isUpvoted;
  RxBool isDownvoted;
  Rx<Color> upvoteColor;
  Rx<Color> downvoteColor;

  ForumModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.content,
    required this.upvote,
    required this.downvote,
    required this.points,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.upvoteColor,
    required this.downvoteColor
  });

  factory ForumModel.fromMap(Map<String, dynamic> mappedForum, String id, bool isUpvoted, bool isDownvoted) {
    return ForumModel(
      id: id,
      title: mappedForum['title'] ?? '',
      author: mappedForum['author'] ?? '',
      description: mappedForum['description'] ?? '',
      content: mappedForum['content'],
      upvote: RxInt(mappedForum['upvote'] ?? 0),
      downvote: RxInt(mappedForum['downvote'] ?? 0),
      points: mappedForum['points'] ?? 0,
      isUpvoted: RxBool(isUpvoted),
      isDownvoted: RxBool(isDownvoted),
      upvoteColor: Rx<Color>(isUpvoted ? Colors.green : Colors.black),
      downvoteColor: Rx<Color>(isDownvoted ? Colors.red : Colors.black),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'content': content,
      'upvote': upvote,
      'downvote': downvote,
      'points' : points,
    };
  }

  void onTapUpvote(){
    final service = Get.find<ForumService>();
    if (!isUpvoted.value) {
      upvote.value++;
      upvoteColor.value = Colors.green;
      isUpvoted.value = true;
      service.onTapUpvotewithUser(
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .uid
              .toString(),
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .displayName
              .toString(),
          id,
          upvote.value,
          downvote.value,
        isUpvoted.value
      );
    } else {
      upvote.value--;
      upvoteColor.value = Colors.black;
      isUpvoted.value = false;
      service.onTapUpvotewithUser(
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .uid
              .toString(),
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .displayName
              .toString(),
          id,
          upvote.value,
          downvote.value,
        isUpvoted.value
      );
    }
  }

  void onTapDownvote() {
    final service = Get.find<ForumService>();
    if (!isDownvoted.value) {
      downvote.value++;
      downvoteColor.value = Colors.red;
      isDownvoted.value = true;
      service.onTapDownvotewithUser(
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .uid
              .toString(),
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .displayName
              .toString(),
          id,
          upvote.value,
          downvote.value,
          isDownvoted.value
      );
    } else {
      downvote.value--;
      downvoteColor.value = Colors.black;
      isDownvoted.value = false;
      service.onTapDownvotewithUser(
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .uid
              .toString(),
          Auth.to
              .GetFireBaseAuth()
              .currentUser!
              .displayName
              .toString(),
          id,
          upvote.value,
          downvote.value,
        isDownvoted.value
      );
    }
  }


}