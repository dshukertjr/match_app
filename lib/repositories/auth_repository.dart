import 'package:app/data_providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRepository {
  final AuthProvider _authProvider;

  AuthRepository({
    @required AuthProvider authProvider,
  }) : _authProvider = authProvider;

  Stream<FirebaseUser> get onAuthStateChanged;

  Future<String> get getUid;

  Future<String> register({@required String email, @required String password});

  Future<String> signInWithEmailAndPassword(
      {@required String email, @required String password});

  Future<void> signOut();
}

class AppAuthRepository extends AuthRepository {
  AppAuthRepository({@required AuthProvider authProvider})
      : super(authProvider: authProvider);

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
}
