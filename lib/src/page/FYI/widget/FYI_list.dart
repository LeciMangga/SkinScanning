// lib/app/page/FYI/views/widgets/FYI_list.dart (Assuming this path or similar)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinscanning/src/core/base_import.dart'; // Assuming this is used for common imports or Get
import 'package:skinscanning/src/page/FYI/FYI_controller.dart';
import '../FYI_detail_view.dart';
import 'FYI_card.dart'; // Assuming FYI_card.dart is in the same directory

class FYIList extends StatelessWidget {
  const FYIList({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the FyiController instance. It should be already initialized.
    final FyiController fyiController = Get.find<FyiController>();

    return Obx(() {
      // Use Obx to listen for changes in the controller's reactive variables

      // Check isLoadingList for the list's loading state
      if (fyiController.isLoadingList.value) {
        return const Center(child: CircularProgressIndicator());
      }
      // Check listErrorMessage for errors related to fetching the list
      else if (fyiController.listErrorMessage.value.isNotEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 40),
                const SizedBox(height: 10),
                Text(
                  'Error: ${fyiController.listErrorMessage.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red.shade700),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  onPressed: () => fyiController.fetchFyiItems(), // Add a retry button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                )
              ],
            ),
          ),
        );
      }
      // Check if the fyiItems list is empty after loading and no error
      else if (fyiController.fyiItems.isEmpty) {
        return const Center(
            child: Text(
              "No FYI items available at the moment.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
        );
      }
      // If data is available, build the list
      else {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          itemCount: fyiController.fyiItems.length,
          itemBuilder: (context, index) {
            final item = fyiController.fyiItems[index];
            return FYICard(
              // Ensure FYICard handles potentially null title and imageUrl gracefully
              title: item.title ?? 'No Title',
              // Provide a default empty string if imageUrl is null to satisfy non-nullable parameter.
              // The FYICard should then handle an empty string (e.g. show placeholder).
              imageUrl: item.imageUrl ?? '',
              onTap: () {
                // Navigate to the detail view, passing the selected fyiItem
                Get.to(() => FYIDetailView(fyiItem: item));
              },
            );
          },
        );
      }
    });
  }
}
