import 'package:app/models/user_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MatchPair {
  const MatchPair({
    this.firstUser,
    this.secondUser,
    this.uids,
    this.likedMap,
    this.matchedAt,
  });

  /// user where firstUser.uid < secondUser.uid
  final UserPublic firstUser;

  /// user where secondUser.uid > firstUser.uid
  final UserPublic secondUser;

  /// user ids of the two users
  final List<String> uids;

  /// Whether each user liked or not
  final Map<String, bool> likedMap;

  final DateTime matchedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstUser': firstUser?.toMap(),
      'secondUser': secondUser?.toMap(),
      'uids': uids,
      'likedMap': likedMap,
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
    @required UserPublic prospect,
    @required UserPublic selfUserPublic,
  }) {
    if (prospect.uid.compareTo(selfUserPublic.uid) < 0) {
      return MatchPair(
        firstUser: prospect,
        secondUser: selfUserPublic,
        uids: <String>[prospect.uid, selfUserPublic.uid],
        likedMap: <String, bool>{
          'secondUser': true,
        },
      );
    } else {
      return MatchPair(
        firstUser: selfUserPublic,
        secondUser: prospect,
        uids: <String>[selfUserPublic.uid, prospect.uid],
        likedMap: <String, bool>{
          'firstUser': true,
        },
      );
    }
  }

  String get documentId {
    return '${uids.first}${uids[1]}';
  }
}
