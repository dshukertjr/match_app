import 'package:flutter/material.dart';

@visibleForTesting
const String requiredMessage = '必須項目です';

@visibleForTesting
const String invalidEmailMessage = 'メールアドレスを入力してください';

@visibleForTesting
const String invalidPasswordMessage = 'パスワードは6文字以上で入力してください';

@visibleForTesting
const String invalidNameMessage = '名前は12文字以内で入力してください';

@visibleForTesting
const String invalidDescriptionMessage =
    'プロフィールは$maxDescriptionLength文字以内で入力してください';

const int maxDescriptionLength = 256;

String Function(String) requiredValidator = (String val) {
  if (val.isEmpty) {
    return requiredMessage;
  }
  return null;
};

String Function(String) nameValidator = (String val) {
  final String checkRequired = requiredValidator(val);
  if (checkRequired != null) {
    return checkRequired;
  }
  if (val.length > 12) {
    return invalidNameMessage;
  }
  return null;
};

String Function(String) descriptionValidator = (String val) {
  if (val.length > 256) {
    return invalidDescriptionMessage;
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
