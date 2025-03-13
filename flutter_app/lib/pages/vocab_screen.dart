import 'dart:async'; // Thêm thư viện này để dùng Timer
import 'package:flutter/material.dart';
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

  Timer? _debounce; // Bộ đếm thời gian để tối ưu gợi ý theo thời gian thực

  void _searchWord(String word) async {
    if (word.isNotEmpty) {
      final data = await _dictionaryService.fetchWord(word);
      setState(() {
        _wordData = data;
      });
    } else {
      setState(() {
        _wordData = null; // Xóa dữ liệu khi người dùng xóa hết ký tự
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
    _debounce?.cancel(); // Hủy timer khi không cần thiết
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            _wordData == null
                ? const Text("Không tìm thấy dữ liệu.")
                : Expanded(
              child: ListView(
                children: [
                  Text("📝 Từ vựng: ${_wordData!.word}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("🔊 Phát âm: ${_wordData!.phonetic}"),
                  _wordData!.audio.isNotEmpty
                      ? ElevatedButton(
                    onPressed: () {
                      // Phát âm nếu có audio
                    },
                    child: const Text('🔊 Nghe phát âm'),
                  )
                      : const Text('🔇 Không có audio'),
                  Text("📖 Định nghĩa: ${_wordData!.definition}"),
                  Text("💬 Ví dụ: ${_wordData!.example}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
