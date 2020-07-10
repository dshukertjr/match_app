import 'package:flutter/material.dart';

@visibleForTesting
const String requiredMessage = '必須項目です';

@visibleForTesting
const String invalidEmailMessage = 'メールアドレスを入力してください';

@visibleForTesting
const String invalidPasswordMessage = 'パスワードは6文字以上で入力してください';

String Function(String) requiredValidator = (String val) {
  if (val.isEmpty) {
    return requiredMessage;
  }
  return null;
};

final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

String Function(String) emailValidator = (String val) {
  if (val.isEmpty) {
    return requiredMessage;
  } else if (!_emailRegex.hasMatch(val)) {
    return invalidEmailMessage;
  }
  return null;
};

String Function(String) passwordValidator = (String val) {
  if (val.isEmpty) {
    return requiredMessage;
  } else if (val.length <= 6) {
    return invalidPasswordMessage;
  }
  return null;
};
