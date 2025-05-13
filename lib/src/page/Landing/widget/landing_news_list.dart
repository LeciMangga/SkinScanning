import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/widget/landing_news_card.dart';

class LandingNewsList extends StatelessWidget {
  final bool isLoading;

  const LandingNewsList({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final newsItems = isLoading
        ? List.generate(3, (index) => {})
        : [
      {
        'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        'title': 'Early Detection of Melanoma Improves Survival by 70%"',
        'author': 'Dr. John Doe, Dermatologist',
        'tag': 'Skin Cancer',
        'time': '1m ago',
      },
      {
        'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        'title': 'Expert Tips: How to Manage Acne Effectively',
        'author': 'Dr. Jane Smith, Dermatologist',
        'tag': 'Acne',
        'time': '5m ago',
      },
      {
        'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        'title': 'Is Your Skincare Routine Damaging Your Skin?',
        'author': 'Dr. Emily Green',
        'tag': 'Skincare',
        'time': '12m ago',
      }
    ];

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
          child: Column(
            children: List.generate(newsItems.length, (index) {
              final item = newsItems[index];
              return LandingNewsCard(
                imageUrl: item['image'],
                title: item['title'],
                author: item['author'],
                tag: item['tag'],
                time: item['time'],
                isLoading: isLoading,
                onTap: () {
                  Get.snackbar("News", "Opening '${item['title']}'");
                },
              );
            }),
          ),
        )
      ],
    );
  }
}
