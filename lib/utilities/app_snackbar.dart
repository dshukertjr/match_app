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
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        borderRadius: 4,
        message: message,
        duration: const Duration(seconds: 4),
        animationDuration: const Duration(milliseconds: 200),
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
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        borderRadius: 4,
        message: message,
        backgroundColor: Theme.of(context).errorColor,
        duration: const Duration(seconds: 4),
        animationDuration: const Duration(milliseconds: 200),
      ).show(context);
    }
  }
}
