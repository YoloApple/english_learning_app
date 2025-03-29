import 'package:flutter/material.dart';
import 'dart:math';
import '../components/FlashcardWidget.dart';
import '../models/flashcard_model.dart';

class CategoryFlashcardView extends StatefulWidget {
  final List<Flashcard> flashcards;
  const CategoryFlashcardView({Key? key, required this.flashcards}) : super(key: key);

  @override
  _CategoryFlashcardViewState createState() => _CategoryFlashcardViewState();
}

class _CategoryFlashcardViewState extends State<CategoryFlashcardView> {
  int currentIndex = 0;

  void _goNext() {
    if (currentIndex < widget.flashcards.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _goPrev() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Hiển thị flashcard hiện tại
        FlashcardWidget(flashcard: widget.flashcards[currentIndex]),
        const SizedBox(height: 20),
        // Các nút điều hướng
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentIndex > 0 ? _goPrev : null,
              icon: const Icon(Icons.arrow_back),
            ),
            Text("${currentIndex + 1} / ${widget.flashcards.length}"),
            IconButton(
              onPressed: currentIndex < widget.flashcards.length - 1 ? _goNext : null,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}
