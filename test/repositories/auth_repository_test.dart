import 'package:app/data_providers/auth_provider.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  group('Auth Repository Test', () {
    test('getUid returns null when the user is not signed in', () async {
      final authProvider = MockAuthProvider();

      when(authProvider.currentUser).thenAnswer((_) async => null);

      expect(await AppAuthRepository(authProvider: authProvider).getUid, null);
    });
  });
}
