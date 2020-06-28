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
}

class AppAuthRepository extends AuthRepository {
  AppAuthRepository({@required AuthProvider authProvider})
      : super(authProvider: authProvider);

  @override
  Stream<FirebaseUser> get onAuthStateChanged =>
      _authProvider.onAuthStateChanged;

  @override
  Future<String> get getUid async => (await _authProvider.currentUser)?.uid;
}
