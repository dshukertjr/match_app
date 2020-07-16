import 'package:app/models/user_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MatchPair {
  const MatchPair({
    this.firstUser,
    this.secondUser,
    this.uids,
    this.matchedAt,
  });

  /// user where firstUser.uid < secondUser.uid
  final UserPublic firstUser;

  /// user where secondUser.uid > firstUser.uid
  final UserPublic secondUser;

  /// user ids of the two users
  final List<String> uids;

  final DateTime matchedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstUser': firstUser?.toMap(),
      'secondUser': secondUser?.toMap(),
      'uids': uids,
      'matchedAt': matchedAt,
    }..removeWhere((_, dynamic value) => value == null);
  }

  static MatchPair fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return MatchPair(
      firstUser: UserPublic.fromMap(map['firstUser'] as Map<String, dynamic>),
      secondUser: UserPublic.fromMap(map['secondUser'] as Map<String, dynamic>),
      uids: List<String>.from(map['uids'] as List<dynamic>),
      matchedAt: (map['matchedAt'] as Timestamp).toDate(),
    );
  }

  static MatchPair fromTwoUserPublic({
    @required UserPublic userPublic1,
    @required UserPublic userPublic2,
  }) {
    if (userPublic1.uid.compareTo(userPublic2.uid) > 0) {
      return MatchPair(
        firstUser: userPublic1,
        secondUser: userPublic2,
        uids: <String>[userPublic1.uid, userPublic2.uid],
      );
    } else {
      return MatchPair(
        firstUser: userPublic2,
        secondUser: userPublic1,
        uids: <String>[userPublic2.uid, userPublic1.uid],
      );
    }
  }

  String get documentId {
    return '${uids.first}${uids[1]}';
  }
}
