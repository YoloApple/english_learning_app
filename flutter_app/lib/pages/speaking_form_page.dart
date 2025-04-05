import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/speaking_model.dart';
import '../providers/speaking_provider.dart';

class SpeakingFormPage extends StatefulWidget {
  @override
  _SpeakingFormPageState createState() => _SpeakingFormPageState();
}

class _SpeakingFormPageState extends State<SpeakingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _englishContentController = TextEditingController();
  final TextEditingController _vietnameseContentController = TextEditingController();

  void _saveTopic() {
    if (_formKey.currentState!.validate()) {
      final newTopic = SpeakingTopic(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        english: _nameController.text,
        vietnamese: _nameController.text,
        content: SpeakingContent(
          english: _englishContentController.text,
          vietnamese: _vietnameseContentController.text,
        ),
      );

      Provider.of<SpeakingProvider>(context, listen: false).addTopic(newTopic);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Speaking Topic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Topic Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _englishContentController,
                decoration: InputDecoration(labelText: 'English Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter English content';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vietnameseContentController,
                decoration: InputDecoration(labelText: 'Vietnamese Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Vietnamese content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTopic,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
