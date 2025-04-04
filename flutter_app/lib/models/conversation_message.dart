enum MessageSender {
  user,
  ai,
}

class ConversationMessage {
  final String text;
  final MessageSender sender;

  ConversationMessage({required this.text, required this.sender});
}
