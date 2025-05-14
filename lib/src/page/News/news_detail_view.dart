import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/News/Widget/news_list.dart';
import 'package:skinscanning/src/page/News/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Template/base_Builder_controller.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  const NewsDetailView({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime? date = (news.timestamp as Timestamp?)?.toDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: Text(news.title ?? 'No Title'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final baseController = Get.find<BaseBuilderController>();
              baseController.onTapNavBar(3);
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((news.imageUrl ?? '').isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(news.imageUrl!),
                  ),
                const SizedBox(height: 16),
                Text(
                  news.title ?? 'No Title',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'By ${news.author ?? 'Unknown'} • ${date?.timeAgo() ?? "N/A"}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                Text(
                  news.content ?? 'No content available.',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
