import 'package:app/utilities/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator', () {
    test('必須項目はnullではだめ', () {
      expect(Validator.requiredValidator(null), Validator.requiredMessage);
    });
    test('必須項目はから文字ではだめ', () {
      expect(Validator.requiredValidator(''), Validator.requiredMessage);
    });
    test('必須項目は一文字でも入っていればオッケー', () {
      expect(Validator.requiredValidator(''), null);
    });
    test('Emailアドレスは適当な文字列ではダメ', () {
      expect(
          Validator.requiredValidator('dfljsa'), Validator.invalidEmailMessage);
    });
    test('普通のメールアドレスならオッケー', () {
      expect(
          Validator.requiredValidator('dshukertjr@gmail.com'), null);
    });
  });
}
