import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HideOnKeyboard extends StatefulWidget {
  final Widget _child;

  const HideOnKeyboard({Key key, Widget child})
      : _child = child,
        super(key: key);
  @override
  _HideOnKeyboardState createState() => _HideOnKeyboardState();
}

class _HideOnKeyboardState extends State<HideOnKeyboard> {
  StreamSubscription<bool> _keyboardListener;
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return _isKeyboardVisible ? Container() : widget._child;
  }

  @override
  void initState() {
    super.initState();
    _keyboardListener = KeyboardVisibility.onChange.listen((bool isVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    });
  }

  @override
  void dispose() {
    _keyboardListener?.cancel();
    super.dispose();
  }
}
