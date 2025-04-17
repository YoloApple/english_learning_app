class ListeningItem {
  final int id;
  final String title;
  final String assetPath;
  final String transcript;

  ListeningItem({
    required this.id,
    required this.title,
    required this.assetPath,
    required this.transcript,
  });

  factory ListeningItem.fromMap(int idx, String path) {
    final fileName = path.split('/').last;              // ex: “foo.mp3”
    final title    = fileName.replaceAll('.mp3', '');
    return ListeningItem(
      id: idx,
      title: title,
      assetPath: path,
      transcript: "",    // để trống, hoặc map sau
    );
  }
}
