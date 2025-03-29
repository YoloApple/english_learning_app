import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/swipe_back_wrapper.dart';
import '../services/dictionary_service.dart';
import '../models/word_model.dart';

class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  final DictionaryService _dictionaryService = DictionaryService();
  WordModel? _wordData;
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _setupListeners(); // Lắng nghe sự kiện AudioPlayer

    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _searchWord(_controller.text.trim());
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _setupListeners() {
    _audioPlayer.onPlayerComplete.listen((_) {
      print("✅ Phát âm thanh hoàn tất.");
    });

    _audioPlayer.onPlayerStateChanged.listen((event) {
      print("🎵 Trạng thái: $event");
    });
  }

  void _searchWord(String word) async {
    if (word.isNotEmpty) {
      final data = await _dictionaryService.fetchWord(word);
      setState(() {
        _wordData = data;
      });
    } else {
      setState(() {
        _wordData = null;
      });
    }
  }

  void _playAudio(String url) async {
    if (url.isEmpty) {
      print("⚠️ Không có URL âm thanh.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("⚠️ Lỗi phát âm: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwipeBackWrapper(
      child: Scaffold(
        appBar: AppBar(title: const Text('Vocab Learning')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Nhập từ cần tra cứu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              if (_isLoading)
                const Center(child: CircularProgressIndicator()),

              _wordData == null
                  ? const Expanded(
                child: Center(child: Text("Không tìm thấy dữ liệu.")),
              )
                  : Expanded(
                child: ListView(
                  children: [
                    Text(
                      "📝 Từ vựng: ${_wordData!.word}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("🔊 Phát âm: ${_wordData!.phonetic}"),
                    if (_wordData!.audio.isNotEmpty)
                      ElevatedButton(
                        onPressed: () => _playAudio(_wordData!.audio),
                        child: const Text('🔊 Nghe phát âm'),
                      )
                    else
                      const Text('🔇 Không có audio'),
                    Text("📖 Định nghĩa: ${_wordData!.definition}"),
                    Text("💬 Ví dụ: ${_wordData!.example}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
