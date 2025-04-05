import 'package:flutter/material.dart';
import 'package:flutter_app/pages/speaking_form_page.dart';
import 'package:flutter_app/pages/speaking_list_page.dart';
import '../components/custom_calendar.dart';
import 'conversation_message_screen.dart';
import 'falshcard_screen.dart'; // Màn hình Flashcard của bạn

class StudyDashboard extends StatefulWidget {
  const StudyDashboard({super.key});

  @override
  State<StudyDashboard> createState() => _StudyDashboardState();
}

class _StudyDashboardState extends State<StudyDashboard> {
  DateTime _selectedDate = DateTime.now();

  // Dữ liệu mẫu cho 4 skill
  final List<Map<String, dynamic>> skills = [
    {"name": "Flashcards", "progress": 100, "status": "Completed", "icon": Icons.menu_book},
    {"name": "Conversation", "progress": 85, "status": "Good work", "icon": Icons.edit},
    {"name": "Speaking", "progress": 100, "status": "Completed", "icon": Icons.mic},
    {"name": "Listening", "progress": 70, "status": "Good work", "icon": Icons.hearing},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lịch
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomCalendar(
                onDaySelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Tiêu đề "Skills"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Skills",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // GridView hiển thị 4 skill
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    if (skill["name"] == "Flashcards") {
                      // Khi chạm vào mục Flashcards, chuyển sang màn hình Flashcard
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FlashcardScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.menu_book, size: 48, color: Colors.blue),
                                SizedBox(height: 8),
                                Text(
                                  "Flashcards",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Tap to practice",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }else if (skill["name"] == "Conversation") {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConversationMessageScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade50,
                                radius: 22,
                                child: Icon(skill["icon"], color: Colors.blue, size: 24),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                skill["name"],
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${skill["progress"]}%",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: skill["progress"] == 100 ? Colors.orange : Colors.orange[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  skill["status"],
                                  style: TextStyle(
                                    color: skill["progress"] == 100 ? Colors.white : Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else if (skill["name"] == "Speaking") {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SpeakingListPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade50,
                                radius: 22,
                                child: Icon(skill["icon"], color: Colors.blue, size: 24),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                skill["name"],
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${skill["progress"]}%",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: skill["progress"] == 100 ? Colors.orange : Colors.orange[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  skill["status"],
                                  style: TextStyle(
                                    color: skill["progress"] == 100 ? Colors.white : Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else {
                      // Các skill khác giữ nguyên giao diện ban đầu
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade50,
                              radius: 22,
                              child: Icon(skill["icon"], color: Colors.blue, size: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              skill["name"],
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${skill["progress"]}%",
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: skill["progress"] == 100 ? Colors.orange : Colors.orange[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                skill["status"],
                                style: TextStyle(
                                  color: skill["progress"] == 100 ? Colors.white : Colors.orange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
