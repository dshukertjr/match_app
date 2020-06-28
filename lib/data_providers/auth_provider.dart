import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthProvider {
  Stream<FirebaseUser> get onAuthStateChanged;

  Future<FirebaseUser> get currentUser;
}

class AppAuthProvider extends AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  @override
  Future<FirebaseUser> get currentUser => _auth.currentUser();
}
