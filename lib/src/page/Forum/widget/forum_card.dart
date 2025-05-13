import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Forum/forum_controller.dart';
import 'package:skinscanning/src/page/Forum/models/forum_model.dart';

class ForumCard extends StatelessWidget {
  final ForumModel forumModel;

  const ForumCard({
    super.key,
    required this.forumModel
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForumController>();
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFFBE0E0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(forumModel.title, style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),),
                SizedBox(height: 1,),
                Text('by : ${forumModel.author}', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),),
                Text(forumModel.description,
                  style: TextStyle(
                    height: 1,
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: forumModel.onTapUpvote,child: SvgPicture.asset('assets/images/upvote.svg',color: forumModel.upvoteColor.value,)),
              Text(forumModel.upvote.toString(), style: TextStyle(color: Colors.green),),
              SizedBox(height: 35,),
              GestureDetector(onTap: forumModel.onTapDownvote,child: SvgPicture.asset('assets/images/downvote.svg',color: forumModel.downvoteColor.value,)),
              Text(forumModel.downvote.toString(), style: TextStyle(color: Colors.red),),
            ],
          )
        ],
      ),
    ));
  }
}
