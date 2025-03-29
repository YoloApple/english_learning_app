class Flashcard{
  final String word;
  final String phonetic;
  final String meaning;
  final String? type; // Nếu có

  Flashcard({
    required this.word,
    required this.phonetic,
    required this.meaning,
    this.type,
});

  factory Flashcard.fromJson(Map<String,dynamic> json){
    return Flashcard(
        word:json['word'],
        phonetic: json['phonetic'],
        meaning: json['meaning'],
        type: json['type'],
    );
  }
}