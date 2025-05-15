
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_content_view.dart';
import 'package:skinscanning/src/page/Forum/models/forum_model.dart';
import 'package:skinscanning/src/page/Forum/models/forum_service.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';

class ForumController extends BaseController with GetSingleTickerProviderStateMixin{

  RxInt forumFetchLimit = 5.obs;
  RxBool forumFetchLoading = true.obs;
  late FocusNode focusNode;
  RxList<ForumModel> forumList = <ForumModel>[].obs;
  late final ForumService forumService;
  Rx<ForumModel?> forumModel = Rx<ForumModel?>(null);
  final commentController = TextEditingController();
  final commentKey = GlobalKey<FormState>();

  RxBool isSendingComment = false.obs;

  RxList<dynamic> commentList = [].obs;

  FormFieldValidator<String?> get commentValidator {
    return (value) {
      if (value == null || value.isEmpty) {
        return "Comment can't be empty";
      }
      return null;
    };
  }

  Future<void> sendComment()async{
    isSendingComment.value = true;
    if (commentKey.currentState!.validate()){
      String comment = commentController.text.trim();
      await forumService.postCommentToFirebase(comment, forumModel.value!);
      commentList.value = await forumService.fetchAllComments(forumModel.value!);
    };
    commentController.clear();
    isSendingComment.value = false;
  }

  Future<void> onTapForumCard(ForumModel forummodel)async{
    forumModel.value = forummodel;
    commentList.value = await forumService.fetchAllComments(forumModel.value!);
    final baseBController = Get.find<BaseBuilderController>();
    baseBController.builded.value = ForumContentView(key: ValueKey("ForumContentView-${forummodel.id}"));
  }


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