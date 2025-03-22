import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/models/conversation_model.dart';

class JsonService {
  Future<List<ConversationPhrase>> loadPhrases() async {
    try {
      // Đọc nội dung file JSON từ assets
      String jsonString = await rootBundle.loadString('assets/sentences.json');

      // Giải mã JSON thành danh sách
      List<dynamic> jsonList = json.decode(jsonString);

      // Chuyển đổi thành danh sách ConversationPhrase
      return jsonList.map((item) {
        return ConversationPhrase(
          id: item['id'] ?? 0,
          english: item['english_phrase'] ?? '',
          vietnamese: item['vietnamese_translation'] ?? '',
          category: item['category'] ?? '',
          tags: item['tags'] ?? '',
        );
      }).toList();
    } catch (e) {
      print("❌ Lỗi khi đọc JSON: $e");
      return [];
    }
  }
}
