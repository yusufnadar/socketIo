import 'package:flutter/material.dart';
import 'package:flutter_chat_app_socket_io/global.dart';
import 'package:flutter_chat_app_socket_io/models/chat_message_model.dart';
import 'package:flutter_chat_app_socket_io/models/user.dart';
import 'package:flutter_chat_app_socket_io/screens/chat_title.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();

  static const String ROUTE_ID = 'chat_screen';
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessageModel> _chatMessages;
  User _toChatUser;
  UserOnlineStatus _userOnlineStatus;

  @override
  void initState() {
    super.initState();
    _chatMessages = [];
    _toChatUser = G.toChatUser;
    _userOnlineStatus = UserOnlineStatus.connecting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          toChatUser: _toChatUser,
          userOnlineStatus: _userOnlineStatus,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    ChatMessageModel chatMessageModel = _chatMessages[index];
                    return Text(chatMessageModel.message);
                  }),
            ),
            _bottomChatArea(),
          ],
        ),
      ),
    );
  }

  Container _bottomChatArea() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [_chatTextArea(), IconButton(icon: Icon(Icons.send), onPressed: () {})],
      ),
    );
  }

  Expanded _chatTextArea() {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10),
          hintText: 'Type Message',
        ),
      ),
    );
  }
}
