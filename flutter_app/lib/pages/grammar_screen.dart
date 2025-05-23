import 'package:flutter/material.dart';
import 'package:flutter_app/components/swipe_back_wrapper.dart';

class GrammarScreen extends StatelessWidget {
  final Map<String, dynamic> tense;

  const GrammarScreen({Key? key, required this.tense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeBackWrapper(
      child: SingleChildScrollView(
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
            Text('Cách dùng:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildUsageSection(tense['usage']),
            SizedBox(height: 20),
            Text('Ví dụ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildExamples(tense['examples']),
          ],
        ),
      ),
    );
  }

  Widget _buildStructureSection(Map<String, dynamic>? structure) {
    if (structure == null) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Affirmative: ${structure['affirmative'] ?? ''}", style: TextStyle(fontSize: 16)),
        SizedBox(height: 4),
        Text("Negative: ${structure['negative'] ?? ''}", style: TextStyle(fontSize: 16)),
        SizedBox(height: 4),
        Text("Interrogative: ${structure['interrogative'] ?? ''}", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildUsageSection(List<dynamic>? usage) {
    if (usage == null || usage.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: usage.map<Widget>((use) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text("• $use", style: TextStyle(fontSize: 16)),
        );
      }).toList(),
    );
  }

  Widget _buildExamples(List<dynamic>? examples) {
    if (examples == null || examples.isEmpty) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: examples.map<Widget>((ex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("• ${ex['sentence']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("  ${ex['translation']}", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
