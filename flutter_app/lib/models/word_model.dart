class WordModel {
  final String word;
  final String phonetic;
  final String audio;
  final String origin;
  final String definition;
  final String example;

  WordModel({
    required this.word,
    required this.phonetic,
    required this.audio,
    required this.origin,
    required this.definition,
    required this.example,
  });

  // Chuyển đổi từ JSON sang Object
  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      word: json['word'] ?? 'N/A',
      phonetic: json['phonetic'] ?? 'N/A',
      audio: json['phonetics'][0]['audio'] ?? '', // Lấy audio đầu tiên nếu có
      origin: json['origin'] ?? 'N/A',
      definition: json['meanings'][0]['definitions'][0]['definition'] ?? 'N/A',
      example: json['meanings'][0]['definitions'][0]['example'] ?? 'No example',
    );
  }
}
