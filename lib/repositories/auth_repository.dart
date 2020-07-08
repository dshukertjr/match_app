import 'dart:io';

import 'package:app/data_providers/auth_provider.dart';
import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository {
  final AuthProvider _authProvider;
  final FirestoreProvider _firestoreProvider;

  AuthRepository({
    @required AuthProvider authProvider,
    @required FirestoreProvider firestoreProvider,
  })  : _authProvider = authProvider,
        _firestoreProvider = firestoreProvider;

  Stream<FirebaseUser> get onAuthStateChanged;

  Future<String> get getUid;

  Future<String> register({@required String email, @required String password});

  Future<String> signInWithEmailAndPassword(
      {@required String email, @required String password});

  Future<void> signOut();

  Future<void> saveProfile({
    @required String name,
    @required File imageFile,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  });
}

class AppAuthRepository extends AuthRepository {
  AppAuthRepository({
    @required AuthProvider authProvider,
    @required FirestoreProvider firestoreProvider,
  }) : super(
          authProvider: authProvider,
          firestoreProvider: firestoreProvider,
        );

  @override
  Stream<FirebaseUser> get onAuthStateChanged =>
      _authProvider.onAuthStateChanged;

  @override
  Future<String> get getUid async => (await _authProvider.currentUser)?.uid;

  @override
  Future<String> register(
      {@required String email, @required String password}) async {
    final result = await _authProvider.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  @override
  Future<String> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final result = await _authProvider.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user.uid;
  }

  @override
  Future<void> signOut() {
    return _authProvider.signOut();
  }

  @override
  Future<void> saveProfile({
    @required String name,
    @required File imageFile,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  }) async {
    final uid = await getUid;
    // TODO upload profile image
    final profile = UserPrivate(
      uid: uid,
      name: name,
      birthDate: birthDate,
      sexualOrientation: sexualOrientation,
      wantSexualOrientation: wantSexualOrientation,
    );
    return _firestoreProvider.saveProfile(uid: uid, profile: profile);
  }
}
