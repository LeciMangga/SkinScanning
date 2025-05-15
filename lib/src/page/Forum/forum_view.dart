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
    controller = Get.put(ForumController());

  }

  @override
  void dispose() {
    Get.delete<ForumController>();
    Get.delete<ForumService>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.onTapGestureDetector(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFBE0E0),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                  'Discuss Forum',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
                ),
                textAlign: TextAlign.center,
              ),
            ),
            controller.forumFetchLoading.value ?
            Center(child: CircularProgressIndicator(),) :
            SingleChildScrollView(
                child: ForumCardList(),
            ),
          ]
        )
      )
    )
    );
  }
}
