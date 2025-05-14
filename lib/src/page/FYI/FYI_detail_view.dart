// lib/app/page/FYI/views/FYI_detail_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/FYI_controller.dart';
import 'package:skinscanning/src/page/FYI/models/FYI_model.dart';


class FYIDetailView extends StatefulWidget {
  final FyiModel fyiItem; // The item passed to this detail view

  const FYIDetailView({super.key, required this.fyiItem});

  @override
  State<FYIDetailView> createState() => _FYIDetailViewState();
}

class _FYIDetailViewState extends State<FYIDetailView> {
  // Find the existing FyiController instance.
  // It should be initialized/put by a parent widget or in app bindings.
  late final FyiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<FyiController>();

    // Fetch details for the current item when the view is initialized.
    // Using addPostFrameCallback to ensure the controller method is called
    // after the first frame is built, which is safer for state updates.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if details for this specific item are already loaded or being loaded
      // to avoid redundant calls if user navigates back and forth quickly.
      // The controller's fetchDiseaseDetailsForItem now has logic to decide if API call is needed.
      _controller.fetchDiseaseDetailsForItem(widget.fyiItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // Get current theme

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_controller.selectedFyiItem.value?.title ?? widget.fyiItem.title ?? "Details")),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Optionally clear details in controller if they shouldn't persist when going back to list
            // _controller.clearDetails();
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Obx(() { // Use Obx for the main content area to react to controller state
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the title from the controller's selected item or the initial widget item
              Text(
                _controller.selectedFyiItem.value?.title ?? widget.fyiItem.title ?? 'Unknown Disease',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Conditional UI based on loading and error states from the controller
              if (_controller.isLoadingDetails.value)
                const Center(child: CircularProgressIndicator())
              else if (_controller.detailErrorMessage.value.isNotEmpty)
                _buildErrorView(_controller.detailErrorMessage.value)
              else
                _buildContentLoaded(), // Main content if no error and not loading

              const SizedBox(height: 30), // Extra spacing at the bottom
            ],
          );
        }),
      ),
    );
  }

  // Widget to display when content is loaded (or available from cache)
  Widget _buildContentLoaded() {
    return Column(
      children: [
        _buildInfoSection(
          // Use image from controller's selected item or initial widget item
          imageUrl: _controller.selectedFyiItem.value?.imageUrl ?? widget.fyiItem.imageUrl,
          content: _controller.currentDescription.value,
        ),
        const SizedBox(height: 20),
        _buildSectionCard(
          title: "Symptoms",
          content: _controller.currentSymptoms.value,
        ),
        const SizedBox(height: 20),
        _buildSectionCard(
          title: "Treatment",
          content: _controller.currentTreatment.value,
        ),
      ],
    );
  }

  // Widget to display error message and a retry button
  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red.shade700, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () => _controller.fetchDiseaseDetailsForItem(widget.fyiItem),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary, // Use theme color
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Builds the top section with Image and Info (Description)
  Widget _buildInfoSection({
    required String? imageUrl,
    required String? content,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade700;
    final Color textColor = Colors.white; // Assuming white text on dark card

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
        children: [
          // Image Container
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade400, // Placeholder color
              borderRadius: BorderRadius.circular(12),
            ),
            child: (imageUrl != null && imageUrl.isNotEmpty)
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2.0,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 40, color: Colors.white70);
                },
              ),
            )
                : const Icon(Icons.image_not_supported, size: 40, color: Colors.white70),
          ),
          const SizedBox(width: 16),
          // Text Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Info",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (content != null && content.isNotEmpty)
                  MarkdownBody(
                    data: content,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                      p: theme.textTheme.bodyMedium?.copyWith(color: textColor, fontSize: 14),
                      // Add more styles for lists, headers if needed
                      listBullet: theme.textTheme.bodyMedium?.copyWith(color: textColor, fontSize: 14),
                      h1: theme.textTheme.titleMedium?.copyWith(color: textColor, fontWeight: FontWeight.w600),
                      h2: theme.textTheme.titleSmall?.copyWith(color: textColor, fontWeight: FontWeight.w600),
                    ),
                  )
                else
                  Text(
                    'No description available or still loading...',
                    style: theme.textTheme.bodyMedium?.copyWith(color: textColor.withOpacity(0.7)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds a generic card for sections like Symptoms and Treatment
  Widget _buildSectionCard({
    required String title,
    required String? content,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade700;
    final Color textColor = Colors.white; // Assuming white text on dark card

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (content != null && content.isNotEmpty)
            MarkdownBody(
              data: content,
              selectable: true,
              styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                p: theme.textTheme.bodyMedium?.copyWith(color: textColor, fontSize: 14),
                listBullet: theme.textTheme.bodyMedium?.copyWith(color: textColor, fontSize: 14),
                h1: theme.textTheme.titleMedium?.copyWith(color: textColor, fontWeight: FontWeight.w600),
                h2: theme.textTheme.titleSmall?.copyWith(color: textColor, fontWeight: FontWeight.w600),
              ),
            )
          else
            Text(
              'No $title information available or still loading...',
              style: theme.textTheme.bodyMedium?.copyWith(color: textColor.withOpacity(0.7)),
            ),
        ],
      ),
    );
  }
}
