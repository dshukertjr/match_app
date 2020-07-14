import 'package:app/models/user_private.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;

  static const String _userPrivatesCollection = 'userPrivates';
  static const String _prospectsCollection = 'prospects';

  Future<void> saveProfile({
    @required String uid,
    @required UserPrivate userPrivate,
  }) {
    assert(uid != null);
    assert(userPrivate != null);
    assert(uid == userPrivate.uid);
    return _firestore
        .document('$_userPrivatesCollection/$uid')
        .setData(userPrivate.toMap(), merge: true);
  }

  Stream<DocumentSnapshot> userPrivateStream(String uid) {
    assert(uid != null);
    return _firestore.document('$_userPrivatesCollection/$uid').snapshots();
  }

  Stream<QuerySnapshot> prospectsStream(String uid) {
    assert(uid != null);
    return _firestore
        .collection(_prospectsCollection)
        .where('prospectFor', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
