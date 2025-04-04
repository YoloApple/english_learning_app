import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/category_screen.dart';
import 'package:flutter_app/pages/conversation_message_screen.dart';
import 'package:flutter_app/pages/conversation_screen.dart';
import 'package:flutter_app/pages/exercise_screen.dart';
import 'package:flutter_app/pages/falshcard_screen.dart';
import 'package:flutter_app/pages/grammar_screen.dart';
import 'package:flutter_app/pages/register_screen.dart';
import 'package:flutter_app/pages/tense_list_screen.dart';
import 'package:flutter_app/pages/vocab_screen.dart';
import 'package:flutter_app/providers/conversation_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/setting_provider.dart';
import 'package:flutter_app/pages/home_screen.dart';
import 'package:flutter_app/pages/login_screen.dart';
import 'package:flutter_app/services/data_loader.dart'; // Import hàm load dữ liệu
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io'; // Import để kiểm tra tệp tồn tại
import 'package:path/path.dart' as path;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Chỉ định đường dẫn tuyệt đối
  await dotenv.load(
    fileName: '.env',
  );



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Gọi hàm loadAndInsertQuestions() nếu bạn muốn seed dữ liệu vào DB khi khởi động
  await loadAndInsertQuestions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => ConversationProvider()),
        // Các provider khác nếu có
      ],
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
        '/register': (context) => const RegisterScreen(),
        '/vocab': (context) => const VocabScreen(),
        '/category': (context) => CategoryScreen(),
        '/conversation': (context) => ConversationScreen(category: ''),
        '/tense_list': (context) => TenseListScreen(),
        '/grammar': (context) => GrammarScreen(tense: {}),  // Chú ý: Cần truyền dữ liệu tense đúng
        '/exercise': (context) => ExerciseScreen(tense: {}), // Chú ý: Cần truyền dữ liệu tense đúng
        '/flashcard': (context) => FlashcardScreen(),
        '/conversation_message':(context) => ConversationMessageScreen()
      },
    );
  }
}
