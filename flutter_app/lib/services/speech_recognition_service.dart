import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognitionService {
  final SpeechToText _speech = SpeechToText();

  bool get isListening => _speech.isListening;

  Future<bool> initSpeech() async {
    return await _speech.initialize();
  }

  Future<void> startListening(Function(String) onResult) async {
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
      listenMode: ListenMode.dictation,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  void cancel() {
    _speech.cancel();
  }

  // 🔽 Hàm giả lập: xử lý âm thanh từ file
  Future<String> recognizeSpeechFromFile(String filePath) async {
    // TODO: Kết nối API nhận diện từ file nếu có
    await Future.delayed(Duration(seconds: 2));
    return "This is a sample recognized speech from audio file.";
  }
}
