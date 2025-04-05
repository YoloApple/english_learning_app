class SpeakingTopic {
  int id;
  String name;
  String english;
  String vietnamese;
  SpeakingContent content;

  SpeakingTopic({
    required this.id,
    required this.name,
    required this.english,
    required this.vietnamese,
    required this.content,
  });

  factory SpeakingTopic.fromJson(Map<String, dynamic> json) {
    return SpeakingTopic(
      id: json['id'],
      name: json['name'],
      english: json['english'],
      vietnamese: json['vietnamese'],
      content: SpeakingContent.fromJson(json['content']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'english': english,
      'vietnamese': vietnamese,
      'content': content.toJson(),
    };
  }
}

class SpeakingContent {
  String english;
  String vietnamese;

  SpeakingContent({required this.english, required this.vietnamese});

  factory SpeakingContent.fromJson(Map<String, dynamic> json) {
    return SpeakingContent(
      english: json['english'],
      vietnamese: json['vietnamese'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'vietnamese': vietnamese,
    };
  }
}
