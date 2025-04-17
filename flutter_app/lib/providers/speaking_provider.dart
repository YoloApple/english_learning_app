import 'package:flutter/material.dart';
import '../models/conversation_speaking_model.dart';
import '../models/speaking_model.dart';
import '../services/speaking_service.dart';

class SpeakingProvider with ChangeNotifier {
  final SpeakingService _service = SpeakingService();
  List<SpeakingTopic> _topics = [];
  List<Conversation> _conversations = [];

  List<SpeakingTopic> get topics => _topics;
  List<Conversation> get conversations => _conversations;

  Future<void> loadTopics() async {
    await _service.loadSpeakingData();
    _topics = _service.topics;
    _conversations = _service.conversations;
    notifyListeners();
  }

  /// Lấy các câu hội thoại cho 1 topic
  List<Conversation> getConversationsForTopic(int topicId) {
    return _conversations.where((c) => c.topicId == topicId).toList();
  }
  List<Conversation> get allConversations => _conversations;
  // (Tuỳ chọn) Thêm, xoá, sửa topic & conversation...
  void addTopic(SpeakingTopic t) { _topics.add(t); notifyListeners(); }
  void addConversation(Conversation c) { _conversations.add(c); notifyListeners(); }
  void deleteTopic(int id) {
    _topics.removeWhere((t) => t.id == id);
    _conversations.removeWhere((c) => c.topicId == id);
    notifyListeners();
  }
  void deleteConversation(int id) {
    _conversations.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
