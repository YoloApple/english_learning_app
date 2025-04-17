class Conversation {
  final int id;
  final int topicId;
  final String english;
  final String vietnamese;

  Conversation({
    required this.id,
    required this.topicId,
    required this.english,
    required this.vietnamese,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      topicId: json['topic_id'],
      english: json['english'],
      vietnamese: json['vietnamese'],
    );
  }
}
