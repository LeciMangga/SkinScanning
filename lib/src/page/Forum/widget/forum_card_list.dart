import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_controller.dart';
import 'package:skinscanning/src/page/Forum/widget/forum_card.dart';

class ForumCardList extends StatefulWidget {
  const ForumCardList({super.key});

  @override
  State<ForumCardList> createState() => _ForumCardListState();
}

class _ForumCardListState extends State<ForumCardList> {


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForumController>();
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(controller.forumList.length, (index){
          return ForumCard(forumModel: controller.forumList[index],);
        })
      ));
  }
}

