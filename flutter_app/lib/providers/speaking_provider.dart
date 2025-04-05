import 'package:flutter/material.dart';
import '../models/speaking_model.dart';
import '../services/speaking_service.dart';

class SpeakingProvider with ChangeNotifier {
  final SpeakingService _service = SpeakingService();
  List<SpeakingTopic> _topics = [];

  List<SpeakingTopic> get topics => _topics;

  Future<void> loadTopics() async {
    await _service.loadSpeakingData();
    _topics = _service.topics;
    notifyListeners();
  }

  void addTopic(SpeakingTopic topic) {
    _topics.add(topic);
    notifyListeners();
  }
}
