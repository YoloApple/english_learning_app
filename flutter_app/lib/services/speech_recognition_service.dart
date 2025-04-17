// lib/services/speech_recognition_service.dart

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/foundation.dart';

class SpeechRecognitionService {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  /// Callback sẽ được gọi khi speech recognition kết thúc
  VoidCallback? onSpeechDone;

  Future<bool> initSpeech() async {
    _isInitialized = await _speech.initialize(
      onStatus: _statusListener,
      onError: _errorListener,
      debugLogging: true,
    );
    return _isInitialized;
  }

  bool get isListening => _speech.isListening;

  Future<void> startListening(
      Function(String, bool) onResult, {
        String localeId = 'en_US',
      }) async {
    if (!_isInitialized) await initSpeech();

    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords, result.finalResult),
      localeId: localeId,
      listenMode: ListenMode.dictation,
      partialResults: true,
      pauseFor: const Duration(seconds: 60),
      listenFor: const Duration(minutes: 10),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<List<LocaleName>> locales() => _speech.locales();

  void _statusListener(String status) {
    if (kDebugMode) {
      print('Speech status: $status');
    }
    if (status == 'done' || status == 'notListening') {
      // Gọi callback khi kết thúc
      onSpeechDone?.call();
    }
  }

  void _errorListener(SpeechRecognitionError error) {
    if (kDebugMode) {
      print('Speech recognition error: ${error.errorMsg} - permanent: ${error.permanent}');
    }
    // Bạn có thể xử lý lỗi ở đây
  }
}
