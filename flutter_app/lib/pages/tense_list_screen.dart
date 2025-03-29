import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/components/swipe_back_wrapper.dart';
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
    return SwipeBackWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chọn Chủ điểm Ngữ pháp'),
          centerTitle: true,
          elevation: 4,
          shadowColor: Colors.black54,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: tenses.length,
          itemBuilder: (context, index) {
            final tense = tenses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TenseDetailScreen(tense: tense),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tense['name'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}