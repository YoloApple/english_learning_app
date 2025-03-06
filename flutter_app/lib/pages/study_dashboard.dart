import 'package:flutter/material.dart';

import '../components/custom_calendar.dart';

class StudyDashboard extends StatefulWidget {
  const StudyDashboard({super.key});

  @override
  State<StudyDashboard> createState() => _StudyDashboardState();
}

class _StudyDashboardState extends State<StudyDashboard> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      _selectedDate = date; // Cập nhật ngày đã chọn
                    });
                  },
                ),
                const SizedBox(height: 20),
        
                // Skills Section
                const Text(
                  "Skills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
        
                const SizedBox(height: 10),
        
                // Skills Grid
                SizedBox(
                  height: 320, // Tăng chiều cao để tránh lỗi
                  child: GridView.builder(
                    shrinkWrap: true, // ✅ Tránh lỗi cuộn lồng nhau
                    physics: NeverScrollableScrollPhysics(), // ✅ Không để GridView cuộn
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8, // Giảm khoảng cách ngang
                      mainAxisSpacing: 8, // Giảm khoảng cách dọc
                      childAspectRatio: 1.2, // ✅ Điều chỉnh tỷ lệ item
                    ),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];

                      return Container(
                        padding: const EdgeInsets.all(12), // Giảm padding
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
                          mainAxisAlignment: MainAxisAlignment.center, // ✅ Căn giữa nội dung
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade50,
                              radius: 22, // ✅ Giảm kích thước icon
                              child: Icon(skill["icon"], color: Colors.blue, size: 24),
                            ),
                            const SizedBox(height: 8), // ✅ Thêm khoảng cách nhỏ
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
                    },
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}

// Dữ liệu mẫu cho Skills
List<Map<String, dynamic>> skills = [
  {"name": "Reading", "progress": 100, "status": "Completed", "icon": Icons.menu_book},
  {"name": "Writing", "progress": 85, "status": "Good work", "icon": Icons.edit},
  {"name": "Speaking", "progress": 100, "status": "Completed", "icon": Icons.mic},
  {"name": "Listening", "progress": 70, "status": "Good work", "icon": Icons.hearing},
];
