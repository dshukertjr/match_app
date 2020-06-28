import 'package:flutter/material.dart';

class Validator {
  @visibleForTesting
  static const requiredMessage = '必須項目です';

  @visibleForTesting
  static const invalidEmailMessage = 'メールアドレスを入力してください';

  @visibleForTesting
  static const invalidPasswordMessage = 'パスワードは6文字以上で入力してください';

  static String Function(String) requiredValidator = (val) {
    if (val.isEmpty) {
      return requiredMessage;
    }
    return null;
  };

  static final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String Function(String) emailValidator = (val) {
    if (val.isEmpty) {
      return requiredMessage;
    } else if (!_emailRegex.hasMatch(val)) {
      return invalidEmailMessage;
    }
    return null;
  };

  static String Function(String) passwordValidator = (val) {
    if (val.isEmpty) {
      return requiredMessage;
    } else if (val.length <= 6) {
      return invalidPasswordMessage;
    }
    return null;
  };
}
