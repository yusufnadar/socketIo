import 'package:flutter/material.dart';
import 'package:flutter_chat_app_socket_io/global.dart';
import 'package:flutter_chat_app_socket_io/models/user.dart';
import 'package:flutter_chat_app_socket_io/screens/chat_users_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static const String ROUTE_ID = 'login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    G.initDummyUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Chat"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _userNameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20)),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                _loginBtnTap();
              },
              child: Text('LOGIN'),
            )
          ],
        ),
      ),
    );
  }

  _loginBtnTap() {
    if (_userNameController.text.isEmpty) {
      return;
    }
    User me = G.dummyUsers[0];
    if (_userNameController.text != 'a') {
      me = G.dummyUsers[1];
    }
    G.loggedInUser = me;
    _openChatUsersListScreen(context);
  }

  _openChatUsersListScreen(context) async {
    await Navigator.pushReplacementNamed(context, ChatUsersScreen.ROUTE_ID);
  }
}
