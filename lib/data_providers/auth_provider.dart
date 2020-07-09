import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  Future<FirebaseUser> get currentUser => _auth.currentUser();

  Future<AuthResult> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> signInWithEmailAndPassword(
      {@required String email, @required String password}) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
