// lib/pages/tense_detail_screen.dart
import 'package:flutter/material.dart';
import 'grammar_screen.dart';
import 'exercise_screen.dart';

class TenseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tense;

  const TenseDetailScreen({Key? key, required this.tense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 tab: Grammar và Exercises
      child: Scaffold(
        appBar: AppBar(
          title: Text(tense['name'] ?? 'Chi tiết ngữ pháp'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Grammar'),
              Tab(text: 'Exercises'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab Grammar: truyền dữ liệu tense vào widget GrammarScreen
            GrammarScreen(tense: tense),
            // Tab Exercises: truyền dữ liệu tense để filter bài tập (nếu cần)
            ExerciseScreen(tense: tense),
          ],
        ),
      ),
    );
  }
}
