// lib/pages/speaking_detail_page.dart

import 'package:flutter/material.dart';
import '../models/conversation_speaking_model.dart';
import '../models/speaking_model.dart';
import '../services/speech_recognition_service.dart';

class SpeakingDetailPage extends StatefulWidget {
  final SpeakingTopic topic;
  const SpeakingDetailPage({Key? key, required this.topic}) : super(key: key);

  @override
  _SpeakingDetailPageState createState() => _SpeakingDetailPageState();
}

class _SpeakingDetailPageState extends State<SpeakingDetailPage> {
  final SpeechRecognitionService _speechService = SpeechRecognitionService();

  bool _isListening = false;
  String _recognizedText = '';
  String _interimText = '';
  Widget? _comparisonWidget;

  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();
    _speechService.onSpeechDone = () {
      // đảm bảo tắt loading khi engine thực sự dừng
      setState(() => _isListening = false);
    };
  }

  /// Xóa hết text cũ và widget so sánh
  void _resetRecognition() {
    setState(() {
      _recognizedText = '';
      _interimText = '';
      _comparisonWidget = null;
    });
  }

  /// Callback nhận kết quả từ service
  void _onSpeechResult(String newText, bool isFinal) {
    setState(() {
      if (isFinal) {
        _recognizedText = _recognizedText.isEmpty
            ? newText
            : '$_recognizedText $newText';
        _interimText = '';
      } else {
        _interimText = newText;
      }
    });
  }

  /// Bấm Bắt đầu: reset vùng dưới và start lại
  void _startListening() async {
    _resetRecognition();
    await _speechService.startListening(
      _onSpeechResult,
      localeId: 'en_US',
    );
    setState(() => _isListening = true);
  }

  /// Bấm Tạm dừng: stop và đảm bảo flag false
  void _stopListening() async {
    await _speechService.stopListening();
    setState(() => _isListening = false);
  }

  /// Bấm Tiếp tục: chỉ start nếu đang tắt
  void _continueListening() async {
    if (_isListening) return;
    await _speechService.startListening(
      _onSpeechResult,
      localeId: 'en_US',
    );
    setState(() => _isListening = true);
  }

  /// So sánh phát âm
  void _checkPronunciation() {
    if (_recognizedText.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Chưa nhận diện được giọng nói.')));
      return;
    }

    late final String original;

    if (widget.topic.content is SpeakingContent) {
      original = (widget.topic.content as SpeakingContent).english;
    } else if (widget.topic.content is Conversation) {
      original = (widget.topic.content as Conversation).english;
    } else {
      original = '';
    }

    final origWords = original.toLowerCase().trim().split(' ');
    final spokenWords = _recognizedText.toLowerCase().trim().split(' ');


    setState(() {
      _comparisonWidget = RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: List.generate(origWords.length, (i) {
            final correct = i < spokenWords.length && origWords[i] == spokenWords[i];
            return TextSpan(
              text: '${origWords[i]} ',
              style: TextStyle(
                color: correct ? Colors.black : Colors.red,
                fontWeight: correct ? FontWeight.normal : FontWeight.bold,
              ),
            );
          }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    late final String englishText;

    if (widget.topic.content is SpeakingContent) {
      englishText = (widget.topic.content as SpeakingContent).english;
    } else if (widget.topic.content is Conversation) {
      englishText = (widget.topic.content as Conversation).english;
    } else {
      englishText = 'Không có nội dung';
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.name)),
      body: SafeArea(
        child: Column(
          children: [
            // Vùng hiển thị đoạn gốc
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey.shade100,
                child: SingleChildScrollView(
                  child: Text(englishText, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),

            // Vùng hiển thị kết quả/interim hoặc so sánh
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                child: SingleChildScrollView(
                  child: _comparisonWidget != null
                      ? _comparisonWidget!
                      : Row(
                    children: [
                      Expanded(
                        child: Text(
                          _interimText.isNotEmpty
                              ? _interimText
                              : (_recognizedText.isNotEmpty
                              ? _recognizedText
                              : 'Kết quả sẽ hiện ở đây'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      if (_isListening)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Nút điều khiển
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isListening ? _stopListening : _startListening,
                      icon: Icon(_isListening ? Icons.pause : Icons.mic),
                      label: Text(_isListening ? 'Tạm dừng' : 'Bắt đầu'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _continueListening,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Tiếp tục'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _checkPronunciation,
                      icon: const Icon(Icons.check),
                      label: const Text('Kiểm tra'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
