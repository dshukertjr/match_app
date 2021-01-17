import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String name = 'ChatPage';
  static Route<dynamic> route() {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => ChatPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('chat'),
      ),
      body: ListView(),
    );
  }
}
