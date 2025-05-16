import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/landing_view.dart';
import 'package:skinscanning/src/page/News/news_view.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';
import 'package:skinscanning/src/page/News/models/newsService.dart';
import 'package:skinscanning/src/page/News/models/news_model.dart';

import 'news_detail_view.dart';


class NewsController extends BaseController with GetSingleTickerProviderStateMixin {
  late FocusNode focusNode;
  final List<String> availableTags = ['Skin Cancer', 'Acne', 'Skincare'];
  RxList<String> selectedTags = <String>[].obs;
  RxList<NewsModel> newsItems = <NewsModel>[].obs;
  late final NewsService _newsService;

  RxBool newsFetchLoading = true.obs;

  void onTapGestureDetector(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void openNewsDetail(NewsModel news) {
    final baseController = Get.find<BaseBuilderController>();
    baseController.selectedIndex.value = 3;
    baseController.builded.value = NewsDetailView(key: ValueKey("NewsDetailView-${news.id}"), news: news);
    // baseController.builded.value = LandingView(key: ValueKey("LandingView"));
  }

  void updateSelectedTags(List<String> tags) {
    print("updateSelectedTags called with tags: $tags"); // Debugging
    selectedTags.assignAll(tags); // Correct way to update RxList
    fetchNews();
  }

  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    _newsService = Get.put(NewsService());
    fetchNews();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async => onGoBack();

  Future<bool> onGoBack() async {
    Get.back();
    return true;
  }

  Future<void> fetchNews() async {
    newsFetchLoading.value = true;
    print("fetchNews called with selectedTags: ${selectedTags.value}"); // Debugging
    print("fetchNews called with selectedTags: ${selectedTags.value}");
    try {
      List<NewsModel> fetchedNews = await _newsService.getNews(selectedTags.value);
      print("fetchNews: Fetched ${fetchedNews.length} news items");
      newsItems.assignAll(fetchedNews); // Use assignAll
    } catch (e) {
      print("Error fetching news: $e");
      Get.snackbar('Error', 'Failed to load news: $e');
    }
    newsFetchLoading.value = false;
  }
}

