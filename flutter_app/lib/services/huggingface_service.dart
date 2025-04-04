import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HuggingFaceService {
  final String _modelUrl = "https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium";
  final String _apiToken = dotenv.env['HUGGING_FACE_API_TOKEN'] ?? "";

  Future<String> getResponse(String userInput) async {
    final response = await http.post(
      Uri.parse(_modelUrl),
      headers: {
        "Authorization": "Bearer $_apiToken",
        "Content-Type": "application/json"
      },
      body: json.encode({
        "inputs": userInput,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Giả sử mô hình trả về kết quả dưới dạng String hoặc cần parse tùy theo định dạng trả về.
      // Kiểm tra tài liệu của mô hình nếu cần xử lý thêm.
      return data.toString();
    } else {
      return "Error: ${response.statusCode}";
    }
  }
}
