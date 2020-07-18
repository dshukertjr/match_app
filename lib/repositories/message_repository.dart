import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/models/match_pair.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageRepository {
  const MessageRepository({
    @required FirestoreProvider firestoreProvider,
  }) : _firestoreProvider = firestoreProvider;

  final FirestoreProvider _firestoreProvider;

  Stream<List<MatchPair>> messageHistoryStream(String uid) {
    return _firestoreProvider.messageHistoryStream(uid).map(
        (QuerySnapshot snap) =>
            snap.documents.map(MatchPair.fromSnap).toList());
  }
}
