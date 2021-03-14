import 'package:flutter/material.dart';
import 'package:flutter_chat_app_socket_io/global.dart';
import 'package:flutter_chat_app_socket_io/models/user.dart';
import 'package:flutter_chat_app_socket_io/screens/auth/login_screen.dart';
import 'package:flutter_chat_app_socket_io/screens/chat_screen.dart';

class ChatUsersScreen extends StatefulWidget {
  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();

  static const String ROUTE_ID = 'chat_users_screen';
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  List<User> _chatUsers;
  bool _connectedToSocket;
  String _connectMessage;

  @override
  void initState() {
    super.initState();
    _chatUsers = G.getUsersFor(G.loggedInUser);
    _connectedToSocket = false;
    _connectMessage = 'Connecting';
    _connectToSocket();
  }

  _connectToSocket() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      print('Connecting Logged In User ${G.loggedInUser.name}, ${G.loggedInUser.id}');
      G.initSocket();
      await G.socketUtils.initSocket(G.loggedInUser);
      G.socketUtils.connectToSocket();
      G.socketUtils.setOnConnectListener(onConnect);
      G.socketUtils.setOnConnectionErrorListener(onConnectionError);
      G.socketUtils.setOnConnectionErrorTimeOutListener(onConnectionTimeout);
      G.socketUtils.setOnDisconnectListener(onDisconnect);
      G.socketUtils.setOnErrorListener(onError);
    });
  }

  onConnect(data) {
    print('Connected $data');
    setState(() {
      _connectedToSocket = true;
      _connectMessage = 'Connected';
    });
  }

  onConnectionError(data) {
    print('onConnectionError $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
    });
  }

  onConnectionTimeout(data) {
    print('onConnectionTimeout $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Timed Out';
    });
  }

  onDisconnect(data) {
    print('onDisconnect $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Disconnected';
    });
  }

  onError(data) {
    print('onError $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
    });
  }

  _openChatScreen(context) async {
    await Navigator.pushNamed(context, ChatScreen.ROUTE_ID);
  }

  _openLoginScreen(context) async {
    await Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Users"), centerTitle: true, actions: [
        IconButton(
            icon: (Icon(Icons.close)),
            onPressed: () {
              _openLoginScreen(context);
            })
      ]),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(_connectedToSocket ? 'Connected' : _connectMessage),
            Expanded(
              child: ListView.builder(
                  itemCount: _chatUsers.length,
                  itemBuilder: (context, index) {
                    User user = _chatUsers[index];
                    return ListTile(
                      onTap: () {
                        G.toChatUser = user;
                        _openChatScreen(context);
                      },
                      title: Text(user.name),
                      subtitle: Text('ID ${user.id}, Email ${user.email}'),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
