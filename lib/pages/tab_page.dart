import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  static const name = 'TabPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => TabPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
