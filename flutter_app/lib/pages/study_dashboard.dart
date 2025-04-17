import 'package:flutter/material.dart';
import 'package:flutter_app/pages/speaking_list_page.dart';
import '../components/custom_calendar.dart';
import 'conversation_message_screen.dart';
import 'falshcard_screen.dart';
import 'listening_list__page.dart';

class StudyDashboard extends StatefulWidget {
  const StudyDashboard({super.key});

  @override
  State<StudyDashboard> createState() => _StudyDashboardState();
}

class _StudyDashboardState extends State<StudyDashboard> {
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> skills = [
    {"name": "Flashcards", "progress": 100, "status": "Completed", "icon": Icons.menu_book},
    {"name": "Conversation", "progress": 85, "status": "Good work", "icon": Icons.edit},
    {"name": "Speaking", "progress": 100, "status": "Completed", "icon": Icons.mic},
    {"name": "Listening", "progress": 70, "status": "Good work", "icon": Icons.hearing},
  ];

  void _navigateToSkill(String name) {
    switch (name) {
      case "Flashcards":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashcardScreen()));
        break;
      case "Conversation":
        Navigator.push(context, MaterialPageRoute(builder: (_) => ConversationMessageScreen()));
        break;
      case "Speaking":
        Navigator.push(context, MaterialPageRoute(builder: (_) => SpeakingListPage()));
        break;
      case "Listening":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ListeningListPage()));
        break;
    }
  }

  Widget _buildSkillCard(Map<String, dynamic> skill) {
    return GestureDetector(
      onTap: () => _navigateToSkill(skill["name"]),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCalendar(
                  onDaySelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: skills.length,
                  itemBuilder: (context, index) => _buildSkillCard(skills[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
