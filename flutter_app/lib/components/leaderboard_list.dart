import 'package:flutter/material.dart';

class LeaderboardList extends StatelessWidget {
  final int? limit; // Thêm tham số giới hạn số lượng

  LeaderboardList({super.key, this.limit});

  final List<Map<String, dynamic>> users = [
    {
      "name": "YoloApple",
      "country": "VietNam",
      "avatar": "assets/images/user1.png",
      "score": "19720",
      "rank up": true,
    },
    {
      "name": "Assasin",
      "country": "VietNam",
      "avatar": "assets/images/user2.png",
      "score": "17720",
      "rank up": true,
    },
    {
      "name": "Optimus Prime",
      "country": "India",
      "avatar": "assets/images/user3.png",
      "score": "16720",
      "rank up": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final displayUsers = limit != null ? users.take(limit!).toList() : users;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayUsers.length,
      itemBuilder: (context, index) {
        final user = displayUsers[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
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
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(user["avatar"]),
                radius: 25,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user["country"],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    user["rank up"] ? Icons.arrow_upward : Icons.remove,
                    color: user["rank up"] ? Colors.green : Colors.grey,
                    size: 18,
                  ),
                  Text(
                    user["score"],
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
