import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/tabs/chat_tab.dart';
import 'package:app/pages/tabs/account_tab.dart';
import 'package:app/pages/tabs/search_tab.dart';
import 'package:app/utilities/auth_navigator.dart';
import 'package:app/widgets/bottom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

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
  int _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CubitListener<AuthCubit, AuthState>(
      listener: navigateOnAuthStateChanged,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: IndexedStack(
                index: _tabIndex,
                children: <Widget>[
                  AccountTab(),
                  SearchTab(),
                  ChatTab(),
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
      ),
    );
  }
}
