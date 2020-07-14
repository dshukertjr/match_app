import 'package:app/data_providers/auth_provider.dart';
import 'package:app/data_providers/firestore_provider.dart';
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
}
