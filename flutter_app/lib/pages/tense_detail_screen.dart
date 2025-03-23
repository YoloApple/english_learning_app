import 'package:flutter/material.dart';
import 'grammar_screen.dart';
import 'exercise_screen.dart';

class TenseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tense;

  const TenseDetailScreen({Key? key, required this.tense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tense['name'] ?? 'Chi tiết ngữ pháp',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 6,
          shadowColor: Colors.black54,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Grammar'),
              Tab(text: 'Exercises'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: [
              GrammarScreen(tense: tense),
              ExerciseScreen(tense: tense),
            ],
          ),
        ),
      ),
    );
  }
}
