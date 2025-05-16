import 'package:get_storage/get_storage.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_controller.dart';
import 'package:skinscanning/src/page/Forum/forum_view.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart';

class ForumContentView extends StatefulWidget {
  const ForumContentView({super.key});

  @override
  State<ForumContentView> createState() => _ForumContentViewState();
}

class _ForumContentViewState extends State<ForumContentView> {




  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForumController>();
    return Obx(() => SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xFFD6D6D6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  final baseBController = Get.find<BaseBuilderController>();
                  baseBController.selectedIndex.value = 1;
                  baseBController.builded.value = ForumView(key: ValueKey("ForumView"));
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
              Text(
                controller.forumModel.value!.title,
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              Text(
                'by : ${controller.forumModel.value!.author}',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              Text(
                '"${controller.forumModel.value!.description}"'
              ),
              SizedBox(height: 10,),
              Text(
                '"${controller.forumModel.value!.author}":\n${controller.forumModel.value!.content}'
              ),
              SizedBox(height: 30,),
              Form(
                key: controller.commentKey,
                child: TextFormField(
                  controller: controller.commentController,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.comment),
                    suffixIcon: GestureDetector(
                      onTap: controller.sendComment,
                      child: controller.isSendingComment.value ? CircularProgressIndicator() : Icon(Icons.send),
                    ),
                    hintText: 'Comment Here',
                    labelText: 'Comment',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0x909090FF),
                    ),
                  ),
                  validator: controller.commentValidator,
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: List.generate(controller.commentList.length, (index){
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.commentList[index]['username'] ?? "Anonymous", style: TextStyle(color: Colors.blueAccent),),
                        Divider(),
                        SizedBox(height: 5,),
                        Text(controller.commentList[index]['comment'] ?? "")
                      ],
                    ),
                  );
                }),
              ),
            ]
        ),
      ),
    )
    );;
  }
}
