// lib/services/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/question_model.dart';

class DBHelper {
  // Sử dụng Singleton để đảm bảo chỉ có 1 instance của DBHelper
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  // Khởi tạo Database
  Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'exercises.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Tạo bảng questions với cấu trúc phù hợp với Question model
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exerciseType TEXT,
        questionText TEXT,
        correctAnswer TEXT,
        type TEXT,
        options TEXT,
        correctOption TEXT
      )
    ''');
  }

  // Thêm một câu hỏi vào database
  Future<int> insertQuestion(Question question) async {
    final db = await database;
    return await db.insert('questions', question.toMap());
  }

  // Thêm một danh sách câu hỏi từ JSON vào database
  Future<void> insertQuestionsFromList(List<Question> questions) async {
    final db = await database;
    // Sử dụng batch để thực hiện nhiều insert cùng lúc
    Batch batch = db.batch();
    for (var question in questions) {
      batch.insert('questions', question.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // Lấy tất cả các câu hỏi từ database
  Future<List<Question>> getQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('questions');
    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }
}
