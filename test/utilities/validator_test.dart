import 'package:app/utilities/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator', () {
    test('必須項目はnullではだめ', () {
      expect(Validator.requiredValidator(null), Validator.requiredMessage);
    });
  });
}
