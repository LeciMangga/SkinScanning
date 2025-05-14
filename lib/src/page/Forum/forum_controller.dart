
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/models/forum_model.dart';
import 'package:skinscanning/src/page/Forum/models/forum_service.dart';

class ForumController extends BaseController with GetSingleTickerProviderStateMixin{

  RxInt forumFetchLimit = 5.obs;
  RxBool forumFetchLoading = true.obs;

  late FocusNode focusNode;

  RxList<ForumModel> forumList = <ForumModel>[].obs;

  late final ForumService forumService;

  void onTapGestureDetector(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  Future<void> fetchForum() async{
    forumFetchLoading.value = true;
    try{
      List<ForumModel> fetchedForum = await forumService.fetchForumsfromFirebase(forumFetchLimit.value);
      print("fetchNews: Fetched ${fetchedForum.length} news items");
      forumList.assignAll(fetchedForum);
    } catch (e){
      print("Error fetching forum: $e");
    }
    forumFetchLoading.value = false;
  }

  @override
  void onInit(){
    super.onInit();
    focusNode = FocusNode();
    forumService = Get.put(ForumService());
    fetchForum();
  }

  @override
  void dispose(){
    focusNode.dispose();
    super.dispose();
  }

  @override
  void onReady() async {
    super.onReady();
    forumService = Get.find<ForumService>();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> onWillPop() async {
    return await onGoBack();
  }

  onGoBack() async {
    Get.back();
    return true;
  }
}