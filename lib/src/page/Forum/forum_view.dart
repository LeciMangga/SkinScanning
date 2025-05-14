import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_controller.dart';
import 'package:skinscanning/src/page/Forum/models/forum_service.dart';
import 'package:skinscanning/src/page/Forum/widget/forum_card_list.dart';

class ForumView extends StatefulWidget {
  const ForumView({super.key});

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {

  late ForumController controller;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ForumController>()) {
      Get.put(ForumController());
    }
  }

  @override
  void dispose() {
    Get.delete<ForumController>();
    Get.delete<ForumService>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForumController>();
    return Obx(() => controller.forumFetchLoading.value ?
    Center(child: CircularProgressIndicator(),) :
    GestureDetector(
      onTap: () {
        controller.onTapGestureDetector(context);
        },
      child: SingleChildScrollView(
        child: ForumCardList(),
      ),
    ));
  }
}
