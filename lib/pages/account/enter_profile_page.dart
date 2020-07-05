import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterProfilePage extends StatelessWidget {
  static const name = 'EnterProfilePage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => EnterProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール登録'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
