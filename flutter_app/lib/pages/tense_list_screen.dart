// lib/pages/tense_list_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'tense_detail_screen.dart';

class TenseListScreen extends StatefulWidget {
  @override
  _TenseListScreenState createState() => _TenseListScreenState();
}

class _TenseListScreenState extends State<TenseListScreen> {
  List<dynamic> tenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTenses();
  }

  Future<void> _loadTenses() async {
    String jsonString = await rootBundle.loadString('assets/grammar.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      tenses = jsonData['tenses'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Chủ điểm Ngữ pháp'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tenses.length,
        itemBuilder: (context, index) {
          final tense = tenses[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(tense['name'] ?? ''),
              subtitle: Text(tense['description'] ?? ''),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TenseDetailScreen(tense: tense),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
