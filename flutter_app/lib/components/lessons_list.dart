import 'package:flutter/material.dart';

class LessonsList extends StatelessWidget {
  LessonsList({super.key});

  // Danh sách bài học
  final List<Map<String, dynamic>> lessons = [
    {
      "title": "Basic English",
      "image": "assets/images/lesson1.png",
      "progress": 0.4, // 40% hoàn thành
    },
    {
      "title": "Advanced Grammar",
      "image": "assets/images/lesson2.png",
      "progress": 0.7, // 70% hoàn thành
    },
    {
      "title": "Conversation Skills",
      "image": "assets/images/lesson3.png",
      "progress": 0.2, // 20% hoàn thành
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, // Chiều cao cho danh sách ngang
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Cuộn ngang
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];

          return GestureDetector(
            onTap: (){
              if (lesson["title"] == "Basic English") {
                Navigator.pushNamed(context, '/vocab'); // Không thay thế, chỉ đẩy lên
              } else if (lesson["title"] == "Conversation Skills") {
                Navigator.pushNamed(context, '/category');
              } else if (lesson["title"] == "Advanced Grammar") {
                Navigator.pushNamed(context, '/tense_list');
              }
            },
            child: Container(
              width: 180, // Độ rộng của từng mục bài học
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hình ảnh bài học
                  Image.asset(
                    lesson["image"],
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
            
                  // Tiêu đề bài học
                  Text(
                    lesson["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
            
                  // Thanh tiến trình
                  LinearProgressIndicator(
                    value: lesson["progress"],
                    backgroundColor: Colors.grey[300],
                    color: Colors.blueAccent,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
