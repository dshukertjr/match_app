import 'package:app/models/match_pair.dart';
import 'package:app/models/user_private.dart';
import 'package:app/models/user_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;

  static const String _userPrivatesCollection = 'userPrivates';
  static const String _userPublicsCollection = 'userPublics';
  static const String _prospectsCollection = 'prospects';
  static const String _matchCollection = 'match';

  static String _prospectDocumentId({
    @required UserPublic userPublic,
    @required String uid,
  }) =>
      '$uid${userPublic.uid}';

  Future<void> saveProfile({
    @required String uid,
    @required UserPrivate userPrivate,
  }) {
    assert(uid != null);
    assert(userPrivate != null);
    assert(uid == userPrivate.uid);

    final WriteBatch batch = _firestore.batch();
    batch.setData(_firestore.document('$_userPrivatesCollection/$uid'),
        userPrivate.toMap());
    batch.setData(
      _firestore.document('$_userPublicsCollection/$uid'),
      UserPublic.fromUserPrivate(userPrivate).toMap(),
    );
    return batch.commit();
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

  Future<void> likeProspect({
    @required String uid,
    @required MatchPair matchPair,
    @required UserPublic prospect,
  }) {
    final WriteBatch batch = _firestore.batch();

    final String prospectDocId =
        _prospectDocumentId(userPublic: prospect, uid: uid);
    batch.delete(_firestore.document('$_prospectsCollection/$prospectDocId'));

    batch.setData(
        _firestore.document('$_matchCollection/${matchPair.documentId}'),
        matchPair.toMap());
    return batch.commit();
  }

  Future<void> dislikeProspect({
    @required String uid,
    @required UserPublic prospect,
  }) {
    final String prospectDocId =
        _prospectDocumentId(userPublic: prospect, uid: uid);
    return _firestore.document('$_prospectsCollection/$prospectDocId').delete();
  }

  Stream<QuerySnapshot> messageHistoryStream(String uid) {
    return _firestore
        .collection(_matchCollection)
        .where('uids', arrayContains: uid)
        .where('likedMap.firstUser', isEqualTo: true)
        .where('likedMap.secondUser', isEqualTo: true)
        .snapshots();
  }
}
