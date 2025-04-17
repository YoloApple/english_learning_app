import 'package:flutter/material.dart';
import 'package:flutter_app/pages/speaking_detail_page.dart';
import 'package:provider/provider.dart';
import '../models/conversation_speaking_model.dart';
import '../providers/speaking_provider.dart';
import 'speaking_form_page.dart';
import '../models/speaking_model.dart';

class SpeakingListPage extends StatefulWidget {
  @override
  _SpeakingListPageState createState() => _SpeakingListPageState();
}

class _SpeakingListPageState extends State<SpeakingListPage> {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!_loaded) {
        Provider.of<SpeakingProvider>(context, listen: false).loadTopics();
        _loaded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Speaking Topics')),
      body: Consumer<SpeakingProvider>(
        builder: (context, provider, child) {
          final topics = provider.topics;
          final conversations = provider.allConversations;

          if (topics.isEmpty && conversations.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          final List<Map<String, dynamic>> items = [
            ...topics.map((t) => {'type': 'topic', 'data': t}),
            ...conversations.map((c) => {'type': 'conversation', 'data': c}),
          ];

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              if (item['type'] == 'topic') {
                final topic = item['data'] as SpeakingTopic;
                return ListTile(
                  leading: Icon(Icons.topic, color: Colors.deepPurple),
                  title: Text(
                    topic.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(topic.english ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SpeakingDetailPage(topic: topic),
                      ),
                    );
                  },
                );
              } else if (item['type'] == 'conversation') {
                final conv = item['data'] as Conversation;
                return ListTile(
                  leading: Icon(Icons.chat, color: Colors.blue),
                  title: Text(conv.english, style: TextStyle(fontSize: 14)),
                  subtitle: Text(conv.vietnamese,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SpeakingDetailPage(
                          topic: SpeakingTopic(
                            id: conv.id,
                            name: 'Conversation',
                            english: conv.english,
                            vietnamese: conv.vietnamese,
                            content: SpeakingContent(
                              english: conv.english,
                              vietnamese: conv.vietnamese,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox.shrink(); // fallback
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SpeakingFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
