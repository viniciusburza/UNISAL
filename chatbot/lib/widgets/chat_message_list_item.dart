import 'package:chatbot/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage chatMessage;
  

  ChatMessageListItem({this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return chatMessage.type == ChatMessageType.sent
        ? _showSentMessage()
        : _showReceivedMessage();
  }

  Widget _showSentMessage({EdgeInsets padding, TextAlign textAlign}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 100.0, right: 0.0),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(64.0, 0.0, 8.0, 0.0),
        trailing: CircleAvatar(child: Text(chatMessage.name.toUpperCase()[0])),
        title: Text(chatMessage.name, textAlign: TextAlign.right),
        subtitle: Text(chatMessage.text, textAlign: TextAlign.right),
        leading: Text(chatMessage.date, textAlign: TextAlign.left),
      ),
    );
  }

  Widget _showReceivedMessage() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 0.0, right: 50.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
        leading: CircleAvatar(child: Text(chatMessage.name.toUpperCase()[0])),
        title: Text(chatMessage.name, textAlign: TextAlign.left),
        subtitle: Text(chatMessage.text, textAlign: TextAlign.left),
        trailing: Text(chatMessage.date, textAlign: TextAlign.left),
      ),
    );
  }
}
