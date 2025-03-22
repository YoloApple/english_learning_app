import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/question_model.dart';
import 'db_helper.dart';


Future<void> loadAndInsertQuestions() async {
  // Đọc file JSON từ assets
  String jsonString = await rootBundle.loadString('assets/questions.json');
  Map<String, dynamic> jsonData = json.decode(jsonString);

  List<dynamic> questionsJson = jsonData['questions'];
  // Chuyển đổi sang List<Question>
  List<Question> questions = questionsJson.map((item) => Question.fromJson(item)).toList();

  // Insert danh sách câu hỏi vào SQLite
  DBHelper dbHelper = DBHelper();
  await dbHelper.insertQuestionsFromList(questions);
}
