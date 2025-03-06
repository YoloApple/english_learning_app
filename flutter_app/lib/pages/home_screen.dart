import 'package:flutter/material.dart';
import 'package:flutter_app/pages/profile_screen.dart';
import 'package:flutter_app/pages/settings_screen.dart';

import '../components/home_content.dart';
import 'study_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Chỉ số tab hiện tại

  // Danh sách màn hình
  static final List<Widget> _screens = [
    const HomeContent(),    // Trang chính
    const StudyDashboard(), // Bảng xếp hạng
    const ProfileScreen(),
    const SettingsScreen()// Hồ sơ cá nhân
  ];

  // Xử lý khi chọn tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Nội dung màn hình thay đổi dựa vào tab

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Study DashBoard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.settings),
              label: "Settings"
          ),
        ],
      ),
    );
  }
}
