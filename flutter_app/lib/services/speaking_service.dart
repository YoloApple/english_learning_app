import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/speaking_model.dart';

class SpeakingService {
  List<SpeakingTopic> _topics = [];

  Future<void> loadSpeakingData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/speaking.json');
      final jsonData = json.decode(jsonString);
      final topicList = jsonData['topics'] as List;
      _topics = topicList.map((e) => SpeakingTopic.fromJson(e)).toList();
      print("Đã load ${_topics.length} topics");
    } catch (e) {
      print("Lỗi khi load dữ liệu: $e");
    }
  }


  List<SpeakingTopic> get topics => _topics;

  void addSpeakingTopic(SpeakingTopic topic) {
    _topics.add(topic);
    // Nếu muốn lưu lại vào file JSON, cần thêm chức năng ghi dữ liệu ra file.
  }
}
