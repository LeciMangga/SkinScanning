import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/FYI_controller.dart';
import 'package:skinscanning/src/page/FYI/widget/FYI_list.dart';

class FyiView extends StatefulWidget {
  const FyiView({super.key});

  @override
  State<FyiView> createState() => _FyiViewState();
}

class _FyiViewState extends State<FyiView> {
  late FyiController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FyiController());
  }

  @override
  void dispose() {
    Get.delete<FyiController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTapGestureDetector(context),
      child: Column(
        children: const [
          Expanded(child: FYIList()), // 💡 This makes the list scrollable
        ],
      ),
    );
  }
}

