import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthProvider {
  Stream<FirebaseUser> get onAuthStateChanged;

  Future<FirebaseUser> get currentUser;

  Future<AuthResult> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  });
}

class AppAuthProvider extends AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  @override
  Future<FirebaseUser> get currentUser => _auth.currentUser();

  @override
  Future<AuthResult> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
