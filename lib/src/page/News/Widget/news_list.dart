import 'package:skinscanning/src/core/base_import.dart';
import '../news_controller.dart';
import 'news_card.dart';
import 'package:skinscanning/src/page/News/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'News',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        controller.newsFetchLoading.value ?
        Center(child: CircularProgressIndicator(),) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: controller.isLoading
              ? const Center(
              child: CircularProgressIndicator())
              : Column(
            children:
            List.generate(controller.newsItems.length, (index) {
              final NewsModel item =
              controller.newsItems[index];
              return NewsCard(
                imageUrl: item.imageUrl,
                title: item.title,
                author: item.author,
                tag: item.tag,
                time: item.timestamp != null
                    ? TimeAgo((item.timestamp as Timestamp)
                    .toDate())
                    .timeAgo()
                    : "N/A",
                isLoading:
                false,
                onTap: () {
                  controller.openNewsDetail(item);
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
