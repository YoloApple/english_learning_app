class ConversationPhrase {
  final int id;
  final String english;
  final String vietnamese;
  final String category;
  final String tags;

  ConversationPhrase({
    required this.id,
    required this.english,
    required this.vietnamese,
    required this.category,
    required this.tags, // Thêm tags
  });
}
