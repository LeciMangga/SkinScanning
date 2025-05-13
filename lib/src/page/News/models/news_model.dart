// lib/app/data/models/news_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? id; // Firestore document ID
  final String? imageUrl;
  final String? title;
  final String? author;
  final String? tag;
  final Timestamp? timestamp;
  final String? content;

  NewsModel({
    this.id,
    this.imageUrl,
    this.title,
    this.author,
    this.tag,
    this.timestamp,
    this.content,
  });

  // Factory method to create a NewsModel from a Firestore DocumentSnapshot
  factory NewsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return NewsModel(
      id: doc.id,
      imageUrl: data?['imageUrl'] as String?,
      title: data?['title'] as String?,
      author: data?['author'] as String?,
      tag: data?['tag'] as String?,
      timestamp: data?['timestamp'] as Timestamp?,
      content: data?['content'] as String?,
    );
  }

  // Convert NewsModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'author': author,
      'tag': tag,
      'timestamp': timestamp ?? Timestamp.now(), // Use current timestamp if not provided
      'content': content,
    };
  }
}