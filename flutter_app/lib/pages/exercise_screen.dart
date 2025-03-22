// lib/pages/exercise_screen.dart
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/db_helper.dart';

class ExerciseScreen extends StatefulWidget {
  final Map<String, dynamic> tense;

  const ExerciseScreen({Key? key, required this.tense}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<Question> _questions = [];
  bool _isLoading = true;
  Map<int, String> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // Lấy câu hỏi từ DB và filter theo tense (exerciseType)
  Future<void> _loadQuestions() async {
    List<Question> allQuestions = await DBHelper().getQuestions();
    // Lọc theo tense: giả sử exerciseType trong câu hỏi trùng với tên tense
    List<Question> filtered = allQuestions.where((q) {
      return q.exerciseType == widget.tense['name'];
    }).toList();

    setState(() {
      _questions = filtered;
      _isLoading = false;
    });
  }

  Widget _buildFillInBlankQuestion(Question question) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.questionText, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _userAnswers[question.id!] = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Nhập đáp án...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceQuestion(Question question) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.questionText, style: TextStyle(fontSize: 16.0)),
            ...question.options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _userAnswers[question.id!],
                onChanged: (value) {
                  setState(() {
                    _userAnswers[question.id!] = value!;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(Question question) {
    if (question.type == 'fill_in_blank') {
      return _buildFillInBlankQuestion(question);
    } else if (question.type == 'multiple_choice') {
      return _buildMultipleChoiceQuestion(question);
    } else {
      return SizedBox.shrink();
    }
  }

  void _submitAnswers() {
    int correctCount = 0;
    _questions.forEach((question) {
      String userAnswer = _userAnswers[question.id!] ?? '';
      bool isCorrect = false;
      if (question.type == 'fill_in_blank') {
        isCorrect = userAnswer.trim().toLowerCase() ==
            question.correctAnswer.trim().toLowerCase();
      } else if (question.type == 'multiple_choice') {
        isCorrect = userAnswer == question.correctOption;
      }
      if (isCorrect) correctCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bạn trả lời đúng $correctCount trên ${_questions.length} câu.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.only(bottom: 80),
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return _buildQuestion(_questions[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitAnswers,
        child: Icon(Icons.check),
      ),
    );
  }
}
