// lib/app/services/gemini_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  GenerativeModel? _model;
  static const _modelName = 'gemini-2.0-flash';
  static const String _apiKey = 'AIzaSyAOyTOI7wPb_rjnWSD5f1UWdB-DuU7BFWA';

  GenerativeModel _getModel() {
    _model ??= GenerativeModel(model: _modelName, apiKey: _apiKey);
    return _model!;
  }

  Future<String> generateText(String prompt) async {
    final model = _getModel();
    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Failed to generate response.';
    } catch (e) {
      print('Error generating text: $e');
      return 'Error generating information.';
    }
  }

  Future<Map<String, String>> generateDiseaseDetails(String diseaseName) async {
    final descriptionPrompt = 'Provide a concise description of $diseaseName.';
    final symptomsPrompt = 'List the common symptoms of $diseaseName.';
    final treatmentPrompt = 'Describe the typical treatments for $diseaseName.';

    final results = await Future.wait([
      generateText(descriptionPrompt),
      generateText(symptomsPrompt),
      generateText(treatmentPrompt),
    ]);

    return {
      'description': results[0],
      'symptoms': results[1],
      'treatment': results[2],
    };
  }
}