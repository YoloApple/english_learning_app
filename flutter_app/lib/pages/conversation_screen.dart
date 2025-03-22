import 'package:flutter/material.dart';
import '../models/conversation_model.dart';
import '../services/json_service.dart';


class ConversationScreen extends StatefulWidget {
  final String category;

  const ConversationScreen({super.key, required this.category});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<ConversationPhrase> _phrases = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    print('Loading data for category: ${widget.category}');
    // Lấy tất cả dữ liệu từ file JSON
    final data = await JsonService().loadPhrases();
    // Lọc theo category
    final filteredData =
    data.where((phrase) => phrase.category == widget.category).toList();
    print('Data loaded: ${filteredData.length} items');
    setState(() {
      _phrases = filteredData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: ListView.builder(
        itemCount: _phrases.length,
        itemBuilder: (context, index) {
          final phrase = _phrases[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: ListTile(
              title: Text(phrase.english,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(phrase.vietnamese),
            ),
          );
        },
      ),
    );
  }
}
