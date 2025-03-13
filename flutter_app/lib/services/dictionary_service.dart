import 'dart:convert';
import 'package:flutter_app/models/word_model.dart';
import 'package:http/http.dart'as http;

class DictionaryService{
  Future<WordModel?> fetchWord(String word) async{
    final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final List<dynamic> data = jsonDecode(response.body); // Sửa thành List
        return WordModel.fromJson(data[0]); // Lấy phần tử đầu tiên trong List
      }else {
        return null; // Trả về null nếu không tìm thấy từ
      }
    }catch(e){
      print("Error: $e");
      return null;
    }
  }
}