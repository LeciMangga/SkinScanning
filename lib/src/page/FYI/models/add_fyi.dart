import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addSkinDiseaseData() async {
  final List<Map<String, dynamic>> skinDiseasesData = [
    {
      "createdAt": Timestamp.fromDate(DateTime.utc(2025, 5, 13, 9, 41, 41)),
      "description": "Eczema, also known as atopic dermatitis, is a chronic skin condition characterized by dry, itchy, and inflamed skin. It often appears in early childhood and may be associated with allergies and asthma.",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Atopic_dermatitis_%28child%29.jpg/300px-Atopic_dermatitis_%28child%29.jpg",
      "symptoms": "Intense itching, dry skin, red patches, thickened skin, small bumps that may leak fluid.",
      "title": "Eczema",
      "treatment": "Moisturizers, topical corticosteroids, calcineurin inhibitors, phototherapy, systemic medications."
    },
    {
      "createdAt": Timestamp.fromDate(DateTime.utc(2025, 5, 13, 10, 15, 22)),
      "description": "Psoriasis is an autoimmune disease that causes skin cells to grow too quickly. This rapid growth leads to a buildup of thick, scaly patches on the skin's surface.",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Psoriasis_-_Severe.JPG/300px-Psoriasis_-_Severe.JPG",
      "symptoms": "Red, scaly patches, itching, burning, soreness, thickened nails, joint pain (in psoriatic arthritis).",
      "title": "Psoriasis",
      "treatment": "Topical treatments (corticosteroids, vitamin D analogs), phototherapy, systemic medications (methotrexate, biologics)."
    },
    {
      "createdAt": Timestamp.fromDate(DateTime.utc(2025, 5, 13, 11, 03, 58)),
      "description": "Rosacea is a chronic skin condition that causes redness and visible blood vessels in the face. It may also cause small, red, pus-filled bumps.",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Rosacea-edit-01.jpg/300px-Rosacea-edit-01.jpg",
      "symptoms": "Facial redness, visible blood vessels, small red bumps, burning or stinging sensation, dry eyes.",
      "title": "Rosacea",
      "treatment": "Topical medications (metronidazole, azelaic acid), oral antibiotics, laser therapy, light therapy."
    },
    {
      "createdAt": Timestamp.fromDate(DateTime.utc(2025, 5, 13, 12, 38, 19)),
      "description": "Tinea versicolor is a fungal infection that causes small, discolored patches of skin. It is caused by a type of yeast that lives on the skin's surface.",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Tinea_versicolor_2.JPG/300px-Tinea_versicolor_2.JPG",
      "symptoms": "Small, discolored patches (white, pink, red, or brown), slight itching, sweating may make it worse.",
      "title": "Tinea Versicolor",
      "treatment": "Topical antifungal creams or shampoos (ketoconazole, selenium sulfide), oral antifungal medication."
    },
    {
      "createdAt": Timestamp.fromDate(DateTime.utc(2025, 5, 13, 13, 12, 05)),
      "description": "Melasma is a skin condition that causes patches of hyperpigmentation, often on the face.  It's more common in women, and often related to hormonal changes.",
      "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Melasma_forehead.JPG/300px-Melasma_forehead.JPG",
      "symptoms": "Patches of darker skin, usually on the cheeks, forehead, nose, or upper lip.",
      "title": "Melasma",
      "treatment": "Topical depigmenting agents (hydroquinone, tretinoin), sun protection, laser therapy, chemical peels."
    }
  ];

  // Get a reference to the collection
  final CollectionReference skinDiseasesCollection = _firestore.collection('diseases');

  // Loop through the data and add each item to the collection
  for (var data in skinDiseasesData) {
    try {
      await skinDiseasesCollection.add(data);
      print('Added document with title: ${data['title']}'); // Optional: Print a confirmation
    } catch (e) {
      print('Error adding document: $e'); // Handle the error
    }
  }
  print('Finished adding data.');
}

