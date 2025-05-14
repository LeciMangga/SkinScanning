import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/widget/landing_news_card.dart';
import 'package:skinscanning/src/page/News/news_controller.dart';
import '../../News/models/news_model.dart';

class LandingNewsList extends StatelessWidget {
  const LandingNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();

    return Obx(() {
      return Column(
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
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: List.generate(controller.newsItems.length, (index) {
                final NewsModel item = controller.newsItems[index];
                return LandingNewsCard(
                  imageUrl: item.imageUrl,
                  title: item.title,
                  author: item.author,
                  tag: item.tag,
                  time: item.timestamp != null
                      ? TimeAgo((item.timestamp as Timestamp).toDate()).timeAgo()
                      : "N/A",
                  onTap: () {
                    controller.openNewsDetail(item);
                  },
                );
              }),
            ),
          ),
        ],
      );
    });
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
