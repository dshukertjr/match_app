import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreProvider extends Mock implements FirestoreProvider {}

void main() {
  group('FirestoreProvider', () {
    test('uid and userPrivate.uid have to match', () {
      final firestoreProvider = MockFirestoreProvider();

      final userPrivate = UserPrivate(
        uid: 'aaa',
        name: 'name',
        sexualOrientation: SexualOrientation.gay,
        wantSexualOrientation: SexualOrientation.gay,
        birthDate: DateTime(2000, 9, 18),
        profileImageUrl: 'https://some.com',
      );

      when(firestoreProvider.saveProfile(
        uid: 'baa',
        userPrivate: userPrivate,
      )).thenThrow(AssertionError());

      expect(
        () =>
            firestoreProvider.saveProfile(uid: 'baa', userPrivate: userPrivate),
        throwsAssertionError,
      );
    });
  });
}
