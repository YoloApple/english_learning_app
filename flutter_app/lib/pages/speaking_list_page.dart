import 'package:flutter/material.dart';
import 'package:flutter_app/pages/speaking_detail_page.dart';
import 'package:provider/provider.dart';
import '../providers/speaking_provider.dart';
import 'speaking_form_page.dart';

class SpeakingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Gọi loadTopics khi màn hình được hiển thị
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpeakingProvider>(context, listen: false).loadTopics();
    });

    return Scaffold(
      appBar: AppBar(title: Text('Speaking Topics')),
      body: Consumer<SpeakingProvider>(  // Sử dụng Consumer để lắng nghe sự thay đổi trong provider
        builder: (context, provider, child) {
          if (provider.topics.isEmpty) {
            return Center(child: CircularProgressIndicator());  // Hiển thị loading khi chưa có chủ đề
          }
          return ListView.builder(
            itemCount: provider.topics.length,
            itemBuilder: (context, index) {
              final topic = provider.topics[index];
              return ListTile(
                title: Text(topic.name), // Hiển thị tên chủ đề
                subtitle: Text(topic.english), // Hiển thị mô tả ngắn tiếng Anh
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpeakingDetailPage(topic: topic),  // Chuyển sang trang chi tiết
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpeakingFormPage()),  // Màn hình thêm chủ đề
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
