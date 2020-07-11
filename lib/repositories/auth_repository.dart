import 'dart:io';

import 'package:app/data_providers/auth_provider.dart';
import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/data_providers/storage_provider.dart';
import 'package:app/models/user_private.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  const AuthRepository({
    @required AuthProvider authProvider,
    @required FirestoreProvider firestoreProvider,
    @required StorageProvider storageProvider,
  })  : _authProvider = authProvider,
        _firestoreProvider = firestoreProvider,
        _storageProvider = storageProvider;

  final AuthProvider _authProvider;
  final FirestoreProvider _firestoreProvider;
  final StorageProvider _storageProvider;

  Stream<FirebaseUser> get onAuthStateChanged =>
      _authProvider.onAuthStateChanged;

  Future<String> get getUid async => (await _authProvider.currentUser)?.uid;

  /// returns uid
  Future<String> register(
      {@required String email, @required String password}) async {
    final AuthResult result =
        await _authProvider.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  /// return uid
  Future<String> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final AuthResult result = await _authProvider.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user.uid;
  }

  Future<void> signOut() {
    return _authProvider.signOut();
  }

  Future<void> saveProfile({
    @required String name,
    @required File imageFile,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  }) async {
    final String uid = await getUid;
    final String imageUrl = await _storageProvider.uploadFile(
        path: 'profileImages/$uid/image.jpg', file: imageFile);
    final UserPrivate userPrivate = UserPrivate(
      uid: uid,
      name: name,
      birthDate: birthDate,
      imageUrls: <String>[imageUrl],
      sexualOrientation: sexualOrientation,
      wantSexualOrientation: wantSexualOrientation,
    );
    return _firestoreProvider.saveProfile(uid: uid, userPrivate: userPrivate);
  }

  Stream<UserPrivate> userPrivateStream(String uid) {
    assert(uid != null);
    return _firestoreProvider.userPrivateStream(uid).map(UserPrivate.fromSnap);
  }
}
