import 'package:skinscanning/src/core/base_import.dart';
import '../news_controller.dart';
import 'news_card.dart';
import 'package:skinscanning/src/page/News/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();

    return Obx(() => Column(
      // Wrap with Obx for reactive updates
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'News',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: controller.isLoading // Use isLoading from controller
              ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
              : Column(
            children:
            List.generate(controller.newsItems.length, (index) {
              final NewsModel item =
              controller.newsItems[index]; // Get NewsModel
              return NewsCard(
                imageUrl: item.imageUrl, // Use fields from NewsModel
                title: item.title,
                author: item.author,
                tag: item.tag,
                time: item.timestamp != null
                    ? (item.timestamp as Timestamp)
                    .toDate()
                    .timeAgo()
                    : "N/A",
                // Format timestamp
                isLoading:
                false, //  NewsCard doesn't need controller.isLoading
                onTap: () {
                  Get.snackbar(
                    "'${item.tag}'",
                    "Opening '${item.title}'",
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.only(bottom: 80),
                  );
                },
              );
            }),
          ),
        )
      ],
    ));
  }
}

extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
