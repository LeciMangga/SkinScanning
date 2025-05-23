import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/FYI_controller.dart';
import 'package:skinscanning/src/page/Landing/widget/skin_info_card.dart';

class SkinInfoList extends StatelessWidget {
  const SkinInfoList({super.key});

  @override
  Widget build(BuildContext context) {


    final controller = Get.find<FyiController>();

    return Obx(()=> Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Skin Diseases Info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.fyiItems.value.length,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              return SkinInfoCard(
                title: controller.fyiItems.value[index].title!,
                onTap: () {
                  controller.openFYIDetails(controller.fyiItems.value[index]);
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
