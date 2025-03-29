import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/category_flashcard_view.dart';
import '../models/flashcard_model.dart';
// Lưu ý: FlashcardWidget đã được sửa lỗi chữ ngược như hướng dẫn trước

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  // Map chứa danh sách flashcard cho từng chủ đề
  final Map<String, List<Flashcard>> flashcardMap = {};
  // Danh sách tên chủ đề
  List<String> categories = [];
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllCategories();
  }

  Future<void> loadAllCategories() async {
    // Đọc file JSON từ assets
    final jsonString = await rootBundle.loadString('assets/flashcard.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Với mỗi key (chủ đề) trong JSON, parse thành List<Flashcard>
    jsonData.forEach((key, value) {
      final List<dynamic> listData = value;
      flashcardMap[key] = listData.map((e) => Flashcard.fromJson(e)).toList();
    });

    categories = flashcardMap.keys.toList();
    _tabController = TabController(length: categories.length, vsync: this);

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildCategoryView(String category) {
    final List<Flashcard> cards = flashcardMap[category] ?? [];
    if (cards.isEmpty) {
      return Center(child: Text("No flashcards for $category"));
    }
    return CategoryFlashcardView(flashcards: cards);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Flashcards")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flashcards"),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: categories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categories.map((cat) {
            return _buildCategoryView(cat);
          }).toList(),
        ),
      ),
    );
  }
}
