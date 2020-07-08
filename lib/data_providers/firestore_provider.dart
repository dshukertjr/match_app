import 'package:app/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreProvider {
  final Firestore _firestore;

  FirestoreProvider(this._firestore);

  Future<void> saveProfile({
    @required String uid,
    @required UserPrivate profile,
  }) {
    return _firestore
        .document('userPrivates/$uid')
        .setData(profile.toMap(), merge: true);
  }
}
