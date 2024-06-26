import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/chat.dart';
import 'package:flutter_course/pages/chat/views/chatPage.dart';
import 'package:flutter_course/pages/chat/views/statusPage.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp Clone"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          labelColor: Colors.black,
          controller: _controller,
          indicatorColor: Colors.black,
          tabs: [
            // Tab(
            //   icon: Icon(Icons.camera_alt),
            // ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          // CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourcechat: widget.sourcechat,
          ),
          StatusPage(),
          Text("Calls"),
        ],
      ),
    );
  }
}
