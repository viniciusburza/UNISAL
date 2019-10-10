enum ChatMessageType { sent, received }

class ChatMessage {
  final String name;
  final String text;
  final ChatMessageType type;
  final String date;

  ChatMessage({
    this.name,
    this.text,
    this.type = ChatMessageType.sent,
    this.date,
  });
}
