import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/conversation_speaking_model.dart';
import '../models/speaking_model.dart';

class SpeakingService {
  List<SpeakingTopic> _topics = [];
  List<Conversation> _conversations = [];

  Future<void> loadSpeakingData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/speaking.json');
      final jsonData = json.decode(jsonString);

      // Load topics
      final topicList = jsonData['topics'] as List;
      _topics = topicList.map((e) => SpeakingTopic.fromJson(e)).toList();

      // Load conversations
      final convList = jsonData['conversations'] as List;
      _conversations = convList.map((e) => Conversation.fromJson(e)).toList();

      print("Loaded ${_topics.length} topics and ${_conversations.length} conversations");
    } catch (e) {
      print("Error loading speaking data: $e");
    }
  }

  List<SpeakingTopic> get topics => _topics;
  List<Conversation> get conversations => _conversations;
}
