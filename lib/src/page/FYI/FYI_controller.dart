// lib/app/page/FYI/controllers/FYI_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart'; // For Timestamp
import 'package:flutter/material.dart'; // For FocusNode, BuildContext
import 'package:get/get.dart'; // For GetX state management
import 'package:skinscanning/src/page/FYI/models/FYI_model.dart';
import 'package:skinscanning/src/page/FYI/models/FYI_service.dart';
import 'package:skinscanning/src/page/Template/base_Builder_controller.dart'; // Assuming this is your base controller or navigation helper
import 'package:skinscanning/src/page/ScanUrSkin/ScanUrSkin_view.dart'; // For navigation


class FyiController extends GetxController with GetSingleTickerProviderStateMixin { // Changed from BaseController if it's not GetxController
  late FocusNode focusNode;
  late final FyiService _fyiService;

  // For the list of FYI items
  RxList<FyiModel> fyiItems = <FyiModel>[].obs;
  RxString listErrorMessage = ''.obs; // Error message for the list
  RxBool isLoadingList = false.obs; // Loading state for the list

  // For the details of a selected FYI item
  Rx<FyiModel?> selectedFyiItem = Rx<FyiModel?>(null);
  Rx<String?> currentDescription = Rx<String?>(null);
  Rx<String?> currentSymptoms = Rx<String?>(null);
  Rx<String?> currentTreatment = Rx<String?>(null);
  RxBool isLoadingDetails = false.obs;
  RxString detailErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fyiService = Get.put(FyiService()); // Initialize and register FyiService
    focusNode = FocusNode();
    fetchFyiItems(); // Fetch items when controller is initialized
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    clearDetails(); // Clear details when controller is closed
    super.onClose();
  }

  // Helper to check if two dates are the same (ignoring time)
  bool _isSameDate(Timestamp? timestamp1, DateTime date2) {
    if (timestamp1 == null) return false;
    final dateTime1 = timestamp1.toDate();
    // Compare year, month, and day in the local timezone
    return dateTime1.year == date2.year &&
        dateTime1.month == date2.month &&
        dateTime1.day == date2.day;
  }

  Future<void> fetchFyiItems() async {
    try {
      isLoadingList.value = true;
      listErrorMessage.value = '';
      final items = await _fyiService.getAllFyiItems();
      fyiItems.assignAll(items);
      if (fyiItems.isEmpty) {
        listErrorMessage.value = "No FYI items found.";
      }
    } catch (e) {
      print("Controller: Error fetching FYI items: $e");
      listErrorMessage.value = 'Failed to load FYI items: $e';
    } finally {
      isLoadingList.value = false;
    }
  }

  Future<void> fetchDiseaseDetailsForItem(FyiModel item) async {
    isLoadingDetails.value = true;
    detailErrorMessage.value = '';
    selectedFyiItem.value = item; // Set the selected item for UI to show title etc.

    // Clear previous details from controller's state
    currentDescription.value = null;
    currentSymptoms.value = null;
    currentTreatment.value = null;

    if (item.id == null) {
      detailErrorMessage.value = 'Error: Item ID is missing. Cannot fetch details.';
      isLoadingDetails.value = false;
      return;
    }

    final DateTime now = DateTime.now();
    // Use local DateTime for "today" comparison. Ensure Firestore Timestamps are also handled consistently.
    final DateTime today = DateTime(now.year, now.month, now.day);

    bool needsApiFetch = false;

    // Condition 1: Details never fetched or fetched on a different day
    if (item.detailsLastFetchedAt == null || !_isSameDate(item.detailsLastFetchedAt, today)) {
      print("Controller: Details for '${item.title}' are old or never fetched. Needs API refresh.");
      needsApiFetch = true;
    }
    // Condition 2: Details were fetched today, but are incomplete (e.g., previous partial failure)
    else if (item.description == null || item.description!.trim().isEmpty ||
        item.symptoms == null || item.symptoms!.trim().isEmpty ||
        item.treatment == null || item.treatment!.trim().isEmpty) {
      print("Controller: Details for '${item.title}' are from today but seem incomplete. Needs API refresh.");
      needsApiFetch = true;
    } else {
      print("Controller: Details for '${item.title}' are current and complete. Using cached data from FyiModel.");
      currentDescription.value = item.description;
      currentSymptoms.value = item.symptoms;
      currentTreatment.value = item.treatment;
      // No API call needed, data is fresh enough and complete.
    }

    if (needsApiFetch) {
      try {
        print("Controller: Initiating API fetch for '${item.title}'.");
        final detailsMap = await _fyiService.fetchAndCacheDiseaseDetails(
          diseaseId: item.id!,
          diseaseTitle: item.title ?? 'Unknown Disease',
        );

        currentDescription.value = detailsMap['description'];
        currentSymptoms.value = detailsMap['symptoms'];
        currentTreatment.value = detailsMap['treatment'];

        // Create an updated FyiModel instance with new details and the current timestamp
        final updatedItem = item.copyWith(
          description: detailsMap['description'],
          symptoms: detailsMap['symptoms'],
          treatment: detailsMap['treatment'],
          detailsLastFetchedAt: Timestamp.now(), // Reflect update locally
        );
        selectedFyiItem.value = updatedItem; // Update the selected item observable

        // Update the item in the main fyiItems list as well, so the list view has fresh data if revisited
        int itemIndex = fyiItems.indexWhere((fyi) => fyi.id == item.id);
        if (itemIndex != -1) {
          fyiItems[itemIndex] = updatedItem;
          fyiItems.refresh(); // Notify listeners of the list change
        }
        print("Controller: Successfully fetched and updated details for '${item.title}'.");

      } catch (e) {
        print("Controller: Error fetching disease details from API for '${item.title}': $e");
        detailErrorMessage.value = 'Failed to fetch fresh details: $e.\nDisplaying older data if available.';

        // Fallback to stale data from the originally passed item if API fails
        if (item.description != null && item.description!.isNotEmpty) currentDescription.value = item.description;
        if (item.symptoms != null && item.symptoms!.isNotEmpty) currentSymptoms.value = item.symptoms;
        if (item.treatment != null && item.treatment!.isNotEmpty) currentTreatment.value = item.treatment;

        if (currentDescription.value == null && currentSymptoms.value == null && currentTreatment.value == null) {
          // If no stale data at all, the error message should reflect that.
          detailErrorMessage.value = 'Failed to fetch details: $e. No cached information available.';
        }
      }
    }
    isLoadingDetails.value = false;
  }

  void clearDetails() {
    selectedFyiItem.value = null;
    currentDescription.value = null;
    currentSymptoms.value = null;
    currentTreatment.value = null;
    isLoadingDetails.value = false;
    detailErrorMessage.value = '';
    print("Controller: Details cleared.");
  }

  // Navigation and UI interaction methods (as per your original controller)
  void onTapGestureDetector(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void goToScanPage() {
    // This navigation logic might need adjustment based on your BaseBuilderController
    // For simplicity, assuming Get.find<BaseBuilderController>() works.
    try {
      final baseController = Get.find<BaseBuilderController>();
      baseController.selectedIndex.value = 4; // Example index
      baseController.builded.value = ScanurskinView(); // Example view
    } catch (e) {
      print("Controller: Error navigating to scan page: $e. BaseBuilderController not found or issue with navigation logic.");
      // Handle navigation error, e.g., show a snackbar
      Get.snackbar("Navigation Error", "Could not go to Scan Ur Skin page.");
    }
  }

  Future<bool> onWillPop() async {
    // Logic for handling back press, e.g., clear details or custom navigation
    // Get.back(); // Default behavior
    return true; // Allow back navigation
  }

  void onGoBack() {
    Get.back();
  }
}
