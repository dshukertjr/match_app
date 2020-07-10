import 'package:app/utilities/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator', () {
    test('必須項目はから文字ではだめ', () {
      expect(requiredValidator(''), requiredMessage);
    });
    test('必須項目は一文字でも入っていればオッケー', () {
      expect(requiredValidator('a'), null);
    });
    test('Emailアドレスは適当な文字列ではダメ', () {
      expect(emailValidator('dfljsa'), invalidEmailMessage);
    });
    test('普通のメールアドレスならオッケー', () {
      expect(emailValidator('dshukertjr@gmail.com'), null);
    });
  });
}
