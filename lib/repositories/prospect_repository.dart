import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/models/match_pair.dart';
import 'package:app/models/user_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProspectRepository {
  ProspectRepository({
    @required FirestoreProvider firestoreProvider,
  }) : _firestoreProvider = firestoreProvider;

  final FirestoreProvider _firestoreProvider;

  Stream<List<UserPublic>> prospectsStream({@required String uid}) {
    return _firestoreProvider.prospectsStream(uid).map(
        (QuerySnapshot querySnapshot) => querySnapshot.documents
            .map<UserPublic>(UserPublic.fromSnap)
            .toList());
  }

  Future<void> like({
    @required UserPublic prospect,
    @required UserPublic selfUserPublic,
    @required String uid,
  }) {
    assert(uid != null);
    assert(prospect != null);
    assert(selfUserPublic != null);

    return _firestoreProvider.likeProspect(
        uid: uid,
        matchPair: MatchPair.fromTwoUserPublic(
            prospect: prospect, selfUserPublic: selfUserPublic),
        prospect: prospect);
  }
}
