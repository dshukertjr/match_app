import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthProvider {
  Stream<FirebaseUser> get onAuthStateChanged;

  Future<FirebaseUser> get currentUser;

  Future<AuthResult> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<AuthResult> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  });

  Future<void> signOut();
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

  @override
  Future<AuthResult> signInWithEmailAndPassword(
      {@required String email, @required String password}) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}
