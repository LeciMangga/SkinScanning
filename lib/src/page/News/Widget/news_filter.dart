import 'package:skinscanning/src/core/base_import.dart';
import '../news_controller.dart';

class NewsFilter extends StatelessWidget {
  const NewsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();
    final List<String> tags = ['Skin Cancer', 'Acne', 'Skincare'];

    return Obx(() => Wrap(
      spacing: 8,
      children: tags.map((tag) {
        final isSelected = controller.selectedTags.contains(tag);
        return FilterChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (selected) {
            final updated = List<String>.from(controller.selectedTags);
            selected ? updated.add(tag) : updated.remove(tag);
            print("NewsFilter: Updated tags: $updated"); // Debugging
            controller.updateSelectedTags(updated);
          },
        );
      }).toList(),
    ));
  }
}
