import 'dart:convert';

class Question {
  int? id;
  String exerciseType;
  String questionText;
  String correctAnswer;
  String type;
  List<String> options;
  String? correctOption;

  Question({
    this.id,
    required this.exerciseType,
    required this.questionText,
    required this.correctAnswer,
    required this.type,
    required this.options,
    this.correctOption,
  });

  // Chuyển đối tượng Question thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseType': exerciseType,
      'questionText': questionText,
      'correctAnswer': correctAnswer,
      'type': type,
      // Chuyển List options thành JSON String
      'options': jsonEncode(options),
      'correctOption': correctOption,
    };
  }

  // Khôi phục đối tượng Question từ Map
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      exerciseType: map['exerciseType'],
      questionText: map['questionText'],
      correctAnswer: map['correctAnswer'],
      type: map['type'],
      // Giải mã JSON String thành List<String>
      options: List<String>.from(jsonDecode(map['options'])),
      correctOption: map['correctOption'],
    );
  }

  // Tạo đối tượng Question từ dữ liệu JSON (từ file question.json)
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      exerciseType: json['exerciseType'] ?? '',
      questionText: json['questionText'] ?? '',
      correctAnswer: json['correctAnswer'] ?? '',
      type: json['type'] ?? '',
      options: json['options'] != null ? List<String>.from(json['options']) : [],
      correctOption: json['correctOption'], // Nếu thiếu, sẽ giữ là null
    );
  }
}
