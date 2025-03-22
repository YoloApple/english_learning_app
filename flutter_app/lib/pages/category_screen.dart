import 'package:flutter/material.dart';
import 'conversation_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Greetings', 'icon': Icons.waving_hand, 'color': Colors.blue},
    {'title': 'Self Introduction', 'icon': Icons.person, 'color': Colors.green},
    {'title': 'Family', 'icon': Icons.family_restroom, 'color': Colors.orange},
    {'title': 'Travel', 'icon': Icons.flight_takeoff, 'color': Colors.purple},
    {'title': 'Restaurant', 'icon': Icons.restaurant, 'color': Colors.red},
    {'title': 'Hotel', 'icon': Icons.hotel, 'color': Colors.teal},
    {'title': 'Airport', 'icon': Icons.airplanemode_active, 'color': Colors.indigo},
    {'title': 'Friends', 'icon': Icons.group, 'color': Colors.pink},
    {'title': 'Phone', 'icon': Icons.phone, 'color': Colors.brown},
    {'title': 'School', 'icon': Icons.school, 'color': Colors.cyan},
    {'title': 'Emergency', 'icon': Icons.warning, 'color': Colors.deepOrange},
    {'title': 'Hospital', 'icon': Icons.local_hospital, 'color': Colors.redAccent},
    {'title': 'Compliment', 'icon': Icons.thumb_up, 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversation Skills')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversationScreen(category: category['title']),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: category['color'],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category['icon'], color: Colors.white, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    category['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
