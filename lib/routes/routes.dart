import 'package:flutter_chat_app_socket_io/screens/auth/login_screen.dart';
import 'package:flutter_chat_app_socket_io/screens/chat_screen.dart';
import 'package:flutter_chat_app_socket_io/screens/chat_users_screen.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.ROUTE_ID: (context) => LoginScreen(),
      ChatUsersScreen.ROUTE_ID: (context) => ChatUsersScreen(),
      ChatScreen.ROUTE_ID: (context) => ChatScreen(),
    };
  }

  static initScreen() {
    return LoginScreen.ROUTE_ID;
  }
}
