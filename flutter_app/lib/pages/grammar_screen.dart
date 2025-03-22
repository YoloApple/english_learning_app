// lib/pages/grammar_screen.dart
import 'package:flutter/material.dart';

class GrammarScreen extends StatelessWidget {
  final Map<String, dynamic> tense;

  const GrammarScreen({Key? key, required this.tense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hiển thị các thông tin từ đối tượng tense
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tense['name'] ?? '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(tense['description'] ?? '', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text('Cấu trúc:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildStructureSection(tense['structure']),
          SizedBox(height: 20),
          Text('Ví dụ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildExamples(tense['examples']),
        ],
      ),
    );
  }

  Widget _buildStructureSection(Map<String, dynamic> structure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Affirmative: ${structure['affirmative']}", style: TextStyle(fontSize: 16)),
        SizedBox(height: 4),
        Text("Negative: ${structure['negative']}", style: TextStyle(fontSize: 16)),
        SizedBox(height: 4),
        Text("Interrogative: ${structure['interrogative']}", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildExamples(List<dynamic> examples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: examples.map<Widget>((ex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text("• $ex", style: TextStyle(fontSize: 16)),
        );
      }).toList(),
    );
  }
}
