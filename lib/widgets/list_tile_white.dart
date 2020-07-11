import 'package:flutter/material.dart';

class ListTileWhite extends StatelessWidget {
  const ListTileWhite({
    Key key,
    String title,
    void Function() onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: ListTile(
        onTap: _onPressed,
        title: Text(_title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
