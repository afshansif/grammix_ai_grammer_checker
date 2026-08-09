enum MessageSender { user, assistant }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final bool isError;

  const ChatMessage({
    required this.text,
    required this.sender,
    this.isError = false,
  });
}
