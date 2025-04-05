import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/speaking_model.dart';
import '../services/speech_recognition_service.dart';

class SpeakingDetailPage extends StatefulWidget {
  final SpeakingTopic topic;

  const SpeakingDetailPage({super.key, required this.topic});

  @override
  _SpeakingDetailPageState createState() => _SpeakingDetailPageState();
}

class _SpeakingDetailPageState extends State<SpeakingDetailPage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final SpeechRecognitionService _speechService = SpeechRecognitionService();

  bool _isRecording = false;
  String? _recordedFilePath;
  String _recognizedText = '';
  String _checkResult = '';

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _speechService.initSpeech();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openAudioSession();
  }

  Future<void> _startRecording() async {
    final filePath = 'audio.wav';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = filePath;
      _checkResult = '';
      _recognizedText = '';
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    if (_recordedFilePath != null) {
      final recognized = await _speechService.recognizeSpeechFromFile(_recordedFilePath!);
      setState(() {
        _recognizedText = recognized;
      });
    }
  }

  void _checkPronunciation() {
    if (_recognizedText.isEmpty) {
      _showSnackBar("Chưa nhận diện được giọng nói.");
      return;
    }

    final original = widget.topic.content.english.toLowerCase().trim();
    final spoken = _recognizedText.toLowerCase().trim();

    // Tính độ tương đồng (simple comparison)
    if (spoken == original) {
      _checkResult = "Phát âm rất tốt!";
    } else {
      _checkResult = "Cần cải thiện. Bạn đã nói: \n\"$_recognizedText\"";
    }

    setState(() {});
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _recorder.closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final englishText = widget.topic.content.english;

    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Đoạn văn tiếng Anh
            Text(
              englishText,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),

            // Ghi âm
            ElevatedButton.icon(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white),
              label: Text(
                _isRecording ? "Dừng ghi âm" : "Ghi âm",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),

            SizedBox(height: 20),

            // Kiểm tra phát âm
            ElevatedButton.icon(
              onPressed: _checkPronunciation,
              icon: Icon(Icons.check, color: Colors.white),
              label: Text(
                "Kiểm tra phát âm",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),

            SizedBox(height: 24),

            // Hiển thị kết quả
            if (_checkResult.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kết quả:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(_checkResult, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
