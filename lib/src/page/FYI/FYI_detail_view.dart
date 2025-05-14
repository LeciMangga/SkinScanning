// lib/app/page/FYI/views/FYI_detail_view.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/FYI/models/FYI_model.dart';
import 'package:skinscanning/src/utils/gemini_service.dart';

class FYIDetailView extends StatefulWidget {
  final FyiModel fyiItem;

  const FYIDetailView({super.key, required this.fyiItem});

  @override
  State<FYIDetailView> createState() => _FYIDetailViewState();
}

class _FYIDetailViewState extends State<FYIDetailView> {
  final GeminiService _geminiService = GeminiService(); // Instantiate the GeminiService
  String? _description;
  String? _symptoms;
  String? _treatment;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDiseaseDetails();
  }

  Future<void> _fetchDiseaseDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final docRef = FirebaseFirestore.instance.collection('diseases').doc(widget.fyiItem.id);

      final details = await _geminiService.generateDiseaseDetails(widget.fyiItem.title ?? '');

      // Always save/update to Firestore
      await docRef.set({
        'title': widget.fyiItem.title,
        'imageUrl': widget.fyiItem.imageUrl,
        'description': details['description'],
        'symptoms': details['symptoms'],
        'treatment': details['treatment'],
      });

      setState(() {
        _description = details['description'];
        _symptoms = details['symptoms'];
        _treatment = details['treatment'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skin Scanning"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.fyiItem.title ?? 'Unknown Disease',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            if (_isLoading)
              Center(child: const CircularProgressIndicator())
            else if (_errorMessage != null)
              Text(_errorMessage!)
            else
              _buildInfoSection(
                imageUrl: widget.fyiItem.imageUrl,
                content: _description,
              ),
            const SizedBox(height: 20),

            if (!_isLoading && _errorMessage == null)
              _buildSectionCard(
                title: "Symptoms",
                content: _symptoms,
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 20),

            if (!_isLoading && _errorMessage == null)
              _buildSectionCard(
                title: "Treatment",
                content: _treatment,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String? imageUrl,
    required String? content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            )
                : const Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Info",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                MarkdownBody( // Replace Text with MarkdownBody
                  data: content ?? 'Fetching information...',
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                    p: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String? content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          MarkdownBody( // Replace Text with MarkdownBody
            data: content ?? 'Fetching information...',
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}