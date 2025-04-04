import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/conversation_message.dart';
import '../services/huggingface_service.dart';

class ConversationProvider extends ChangeNotifier {
  final HuggingFaceService _huggingFaceService = HuggingFaceService();

  List<ConversationMessage> _messages = [];
  List<ConversationMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String userMessage) async {
    _messages.add(ConversationMessage(text: userMessage, sender: MessageSender.user));
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    String response = await _huggingFaceService.getResponse(userMessage);

    _isLoading = false;
    notifyListeners();

    // Dùng regex lấy nội dung bên trong generated_text
    RegExp regex = RegExp(r'generated_text:\s*(.*?)[\]}]');
    Match? match = regex.firstMatch(response);
    String processedResponse = match != null ? match.group(1)!.trim() : response;

    // Xóa phần trùng lặp
    if (processedResponse.toLowerCase().startsWith(userMessage.toLowerCase())) {
      processedResponse = processedResponse.substring(userMessage.length).trim();
    }

    if (processedResponse.isNotEmpty) {
      _messages.add(ConversationMessage(text: processedResponse, sender: MessageSender.ai));
      notifyListeners();
    }
  }

}
