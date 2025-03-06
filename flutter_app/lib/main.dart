import 'package:flutter/material.dart';
import 'package:flutter_app/providers/setting_provider.dart';
import 'package:provider/provider.dart'; // Đã cài provider chưa?
import 'package:flutter_app/pages/home_screen.dart';
import 'package:flutter_app/pages/login_screen.dart';
 // Kiểm tra đường dẫn!

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "English-Learning-App",
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      locale: settings.locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
