# SkinScanning AI: Early Skin Disease Awareness & Community Support

**Team Name:** Mangga Leci 777
**Team Leader:** Ahmad Daffa Aminuddin Siregar
**Google Solution Challenge 2025** (Date: May 17, 2025)

## 1. Problem Statement

Our project addresses critical challenges in dermatological health and patient well-being:

* **Late/Missed Diagnoses:** Delayed detection of serious skin conditions like melanoma significantly increases mortality rates and treatment costs. Early awareness is paramount.
* **Psychological Distress & Stigma:** Individuals with visible skin conditions (e.g., psoriasis, eczema, acne) often experience severe psychological distress, social isolation, and stigma, impacting their quality of life.
* **Misinformation & Lack of Accessible Knowledge:** Widespread misconceptions about skin diseases and their treatments hinder effective management, leading to worsened conditions and increased healthcare burdens.

There is an urgent need for accessible, rapid, and accurate tools that not only aid in early awareness but also provide community support and reliable education to combat these issues.

## 2. Our Solution: An AI-Powered Skin Health Platform

SkinScanning AI is a comprehensive mobile application designed to empower users in managing their skin health. We provide a holistic platform integrating:

1.  **AI-Driven Early Detection:** Users can scan skin concerns using their phone camera. Our AI, leveraging Google's advanced Derm Foundation model for feature extraction and a custom-trained classifier, provides an initial assessment to encourage timely professional medical consultation.
2.  **Supportive Community Platform:** A safe and moderated space for users to connect, share experiences, ask questions, and find peer support, helping to reduce feelings of isolation and stigma.
3.  **Reliable Educational Forum:** An accessible library of information on various skin diseases, including descriptions, common symptoms, and general treatment approaches. This content is enriched and kept up-to-date using Google's Gemini API to ensure accuracy and combat misinformation.

Our solution aims to make skin health management more proactive, informed, and supportive for everyone.

## 3. Key Features

* **AI Skin Scan:** Capture or upload a photo of a skin concern for an AI-generated initial assessment and insights.
* **Scan History:** Securely store and track past scans and results.
* **Educational Forum (FYI Section):** Browse detailed, AI-enhanced information on a wide range of skin conditions.
* **Community Hub:** Engage in discussions, share experiences, and connect with others in a supportive environment.
* **User Authentication:** Secure user accounts for personalized experience and data privacy.

## 4. Architecture Overview

Our solution utilizes a robust and scalable cloud-native architecture:

* **Frontend:** A cross-platform mobile application built with **Flutter**.
* **Backend API & Custom AI Model Serving:** A Python **Flask** application (served by **Gunicorn**) running in a Docker container on **Google Cloud Run**. This backend:
    * Receives image scan requests.
    * Orchestrates calls to the Derm Foundation model.
    * Runs the custom Logistic Regression classifier on the embeddings.
    * (Potentially) Interacts with the Gemini API for content updates.
* **AI Feature Extraction:** The **Derm Foundation Model** deployed on a **Vertex AI Endpoint** provides powerful image embeddings.
* **AI Content Generation:** **Google's Gemini API** is used to generate and enrich educational content.
* **Database & User Management:** **Firebase** services:
    * **Firebase Authentication** for user sign-up/login.
    * **Firebase Firestore** for storing user profiles, scan history, community posts, and educational content.
    * **Firebase Storage** (optional) for storing images associated with scan history.
* **Containerization & Registry:** **Docker** for packaging the backend, and **Google Artifact Registry** for storing Docker images.
* **Development Environment:** **Vertex AI Workbench** (JupyterLab) for AI model development and data processing.

![Class Diagram](assets/images/ClassDiagram.drawio.png)


## 5. Technology Stack

* **Mobile App:** Flutter, Dart
* **Backend API:** Python, Flask, Gunicorn
* **AI Model - Feature Extraction:** Vertex AI Endpoint (Derm Foundation Model)
* **AI Model - Custom Classifier:** Scikit-learn (Logistic Regression)
* **AI Content Generation:** Gemini API (via Google Generative AI or Vertex AI)
* **Database & User Management:** Firebase (Firestore, Authentication, Storage)
* **Containerization & Registry:** Docker, Google Artifact Registry
* **Cloud Deployment:** Google Cloud Run (for custom backend), Vertex AI (for Derm Foundation)
* **Cloud Platform:** Google Cloud Platform (GCP) & Firebase
* **Development Environment:** Vertex AI Workbench (JupyterLab)
* **Data Source (for training):** Kaggle Datasets

## 6. Setup and Getting Started

(This section would typically include instructions for developers to set up the project locally. For the Solution Challenge, you might briefly mention the key components.)

* **Backend Deployment:**
    1.  The custom classifier (Logistic Regression model) is trained on embeddings generated by the Derm Foundation model.
    2.  The backend (Flask app with the classifier) is containerized using Docker.
    3.  The Docker image is pushed to Google Artifact Registry.
    4.  The container is deployed as a service on Google Cloud Run.
    5.  The Derm Foundation model is separately deployed on a Vertex AI Endpoint.
* **Flutter Application:**
    1.  Clone the repository.
    2.  Ensure Flutter SDK is installed.
    3.  Configure Firebase project details in the Flutter app.
    4.  Update the Cloud Run API endpoint URL in the Flutter app.
    5.  Run `flutter pub get` and then `flutter run`.

## 7. Future Development

* **AI Advancement & Accessibility:**
    * Expand disease detection coverage & introduce AI-driven severity assessment.
    * Explore on-device ML (Firebase ML & TensorFlow Lite) for offline "quick check" features.
* **Enhanced User Support & Engagement:**
    * Develop personalized wellness journeys and introduce moderated expert Q&A.
* **Platform Evolution & Scalability:**
    * Pilot telehealth integration pathways (adhering to privacy & regulatory standards).
    * Future Goal: Consider migrating the custom classifier from Cloud Run to a Vertex AI Endpoint for a unified MLOps pipeline.
    * Explore anonymized data contributions to public health research (with user consent).

