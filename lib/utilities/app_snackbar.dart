import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static regular({
    @required BuildContext context,
    @required String message,
  }) {
    {
      assert(context != null);
      assert(message != null);
      Flushbar(
        message: message,
        duration: Duration(seconds: 4),
      )..show(context);
    }
  }

  static error({
    @required BuildContext context,
    @required String message,
  }) {
    {
      assert(context != null);
      assert(message != null);
      Flushbar(
        message: message,
        duration: Duration(seconds: 4),
      )..show(context);
    }
  }
}
