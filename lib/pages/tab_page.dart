import 'package:app/pages/tabs/search_page.dart';
import 'package:app/widgets/bottom_tab_bar.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  static const String name = 'TabPage';
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: name),
      builder: (_) => TabPage(),
    );
  }

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: IndexedStack(
              index: _tabIndex,
              children: <Widget>[
                SearchTab(),
              ],
            ),
          ),
          BottomTabBar(
            onTabChanged: (int index) {
              setState(() {
                _tabIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
