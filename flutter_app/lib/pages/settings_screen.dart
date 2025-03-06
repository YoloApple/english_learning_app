import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/setting_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: settings.isDarkMode,
              onChanged: (value) => settings.toggleDarkMode(), // Cập nhật global
            ),

            const SizedBox(height: 20),
            const Text("Language", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // Language Selection
            ListTile(
              title: const Text("English"),
              onTap: () => settings.changeLanguage('en'),
              trailing: settings.locale.languageCode == 'en' ? const Icon(Icons.check) : null,
            ),
            ListTile(
              title: const Text("Tiếng Việt"),
              onTap: () => settings.changeLanguage('vi'),
              trailing: settings.locale.languageCode == 'vi' ? const Icon(Icons.check) : null,
            ),
            ListTile(
              title: const Text("中文"),
              onTap: () => settings.changeLanguage('zh'),
              trailing: settings.locale.languageCode == 'zh' ? const Icon(Icons.check) : null,
            ),
          ],
        ),
      ),
    );
  }
}
