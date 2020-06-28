import 'package:flutter/material.dart';

/// Custom loader that will be shown when the app is loading something.
class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
