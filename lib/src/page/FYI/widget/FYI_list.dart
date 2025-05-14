import 'package:skinscanning/src/core/base_import.dart';
import '../FYI_controller.dart';
import 'FYI_card.dart';

class FYIList extends StatelessWidget {
  const FYIList({super.key});

  @override
  Widget build(BuildContext context) {
    // Get an instance of your FyiController
    final FyiController fyiController = Get.find<FyiController>();

    return Obx(() {
      // Use Obx to listen for changes in the fyiItems list
      if (fyiController.isLoading) {
        // Show a loading indicator while data is being fetched
        return const Center(child: CircularProgressIndicator()); // Or any other loading widget
      } else if (fyiController.errorMessage.isNotEmpty) {
        // Show an error message if there's an error
        return Center(child: Text('Error: ${fyiController.errorMessage.value}'));
      } else if (fyiController.fyiItems.isEmpty) {
        return const Center(child: Text("No items available."));
      }
      else {
        // Build the list using the data from the controller
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          itemCount: fyiController.fyiItems.length,
          itemBuilder: (context, index) {
            final item = fyiController.fyiItems[index];
            return FYICard(
              title: item.title ?? '', // Use null-aware operator in case of null values
              imageUrl: item.imageUrl ??
                  '', //  Use null-aware operator in case of null values
              onTap: () {
                // Handle the tap event, e.g., navigate to a detail view
                // You can pass the item to the detail view if needed
                // Get.to(() => FYI_DetailView(fyiItem: item)); // Example
              },
            );
          },
        );
      }
    });
  }
}
