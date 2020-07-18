import 'package:path/path.dart';
import 'package:app/data_providers/auth_provider.dart';
import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/data_providers/storage_provider.dart';
import 'package:app/models/editing_profile_image.dart';
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
    String description,
    @required List<EditingProfileImage> editingProfileImages,
    @required DateTime birthDate,
    @required String sexualOrientation,
    @required String wantSexualOrientation,
  }) async {
    assert(name != null);
    assert(editingProfileImages != null);

    final String uid = await getUid;
    List<String> imageUrls = <String>[];
    if (editingProfileImages.isNotEmpty) {
      final List<Future<String>> futures = editingProfileImages
          .where((EditingProfileImage editingProfileImage) =>
              editingProfileImage != null)
          .map<Future<String>>((EditingProfileImage editingProfileImage) {
        if (editingProfileImage.imageFile != null) {
          final String fileName = basename(editingProfileImage.imageFile.path);
          return _storageProvider.uploadFile(
              path: 'profileImages/$uid/$fileName',
              file: editingProfileImage.imageFile);
        } else {
          return Future<String>.value(editingProfileImage.imageUrl);
        }
      }).toList();
      imageUrls = await Future.wait(futures);
    }
    final UserPrivate userPrivate = UserPrivate(
      uid: uid,
      name: name,
      description: description,
      birthDate: birthDate,
      imageUrls: imageUrls,
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
