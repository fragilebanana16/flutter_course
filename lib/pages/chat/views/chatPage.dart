import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/chat.dart';
import 'package:flutter_course/pages/chat/views/Widgets/customCard.dart';
import 'package:flutter_course/pages/chat/views/selectContact.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "chatPageTag",
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourcechat: widget.sourcechat,
        ),
      ),
    );
  }
}
