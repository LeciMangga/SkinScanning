import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/News/news_controller.dart';
import 'package:skinscanning/src/page/News/widget/news_filter.dart';
import 'package:skinscanning/src/page/News/widget/news_list.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late NewsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NewsController());
  }

  @override
  void dispose() {
    Get.delete<NewsController>(); // Proper cleanup if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTapGestureDetector(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: NewsFilter(),
          ),
          SizedBox(height: 10),
          NewsList(),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
