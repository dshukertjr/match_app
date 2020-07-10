import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static void regular({
    @required BuildContext context,
    @required String message,
  }) {
    {
      assert(context != null);
      assert(message != null);
      Flushbar<void>(
        message: message,
        duration: const Duration(seconds: 4),
      ).show(context);
    }
  }

  static void error({
    @required BuildContext context,
    @required String message,
  }) {
    {
      assert(context != null);
      assert(message != null);
      Flushbar<void>(
        message: message,
        duration: const Duration(seconds: 4),
      ).show(context);
    }
  }
}
