import 'package:app/data_providers/auth_provider.dart';
import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/data_providers/storage_provider.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

class MockFirestoreProvider extends Mock implements FirestoreProvider {}

class MockStorageProvider extends Mock implements StorageProvider {}

class MockFirebaseUser extends Mock implements FirebaseUser {
  MockFirebaseUser({
    @required this.uid,
  });

  @override
  final String uid;
}

void main() {
  group('Auth Repository Test', () {
    test('getUid returns null when the user is not signed in', () async {
      final MockAuthProvider authProvider = MockAuthProvider();
      final MockFirestoreProvider firestoreProvider = MockFirestoreProvider();
      final MockStorageProvider storageProvider = MockStorageProvider();

      when(authProvider.currentUser).thenAnswer((_) async => null);

      expect(
          await AuthRepository(
            authProvider: authProvider,
            firestoreProvider: firestoreProvider,
            storageProvider: storageProvider,
          ).getUid,
          null);
    });

    test('getUid returns the uid when the user is signed in', () async {
      final MockAuthProvider authProvider = MockAuthProvider();
      final MockFirestoreProvider firestoreProvider = MockFirestoreProvider();
      final MockStorageProvider storageProvider = MockStorageProvider();

      when(authProvider.currentUser)
          .thenAnswer((_) async => MockFirebaseUser(uid: 'aaa'));

      expect(
        await AuthRepository(
          authProvider: authProvider,
          firestoreProvider: firestoreProvider,
          storageProvider: storageProvider,
        ).getUid,
        'aaa',
      );
    });
  });
}
