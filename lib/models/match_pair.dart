import 'package:app/models/message.dart';
import 'package:app/models/user_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MatchPair {
  const MatchPair({
    @required this.firstUser,
    @required this.secondUser,
    @required this.uids,
    @required this.likedMap,
    @required this.matchedAt,
    @required this.lastMessage,
  });

  /// user where firstUser.uid < secondUser.uid
  final UserPublic firstUser;

  /// user where secondUser.uid > firstUser.uid
  final UserPublic secondUser;

  /// user ids of the two users
  final List<String> uids;

  /// Whether each user liked or not
  final Map<String, bool> likedMap;

  /// time at which these users matches
  final DateTime matchedAt;

  /// last message sent in this thread
  final Message lastMessage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstUser': firstUser?.toMap(),
      'secondUser': secondUser?.toMap(),
      'uids': uids,
      'likedMap': likedMap,
      'matchedAt': matchedAt,
      'lastMessage': lastMessage,
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
      lastMessage: Message.fromMap(map['lastMessage'] as Map<String, dynamic>),
      likedMap: Map<String, bool>.from(map['likeMap'] as Map<dynamic, dynamic>),
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
        lastMessage: null,
        matchedAt: null,
      );
    } else {
      return MatchPair(
        firstUser: selfUserPublic,
        secondUser: prospect,
        uids: <String>[selfUserPublic.uid, prospect.uid],
        likedMap: <String, bool>{
          'firstUser': true,
        },
        lastMessage: null,
        matchedAt: null,
      );
    }
  }

  static MatchPair fromSnap(DocumentSnapshot snap) {
    return MatchPair(
      firstUser:
          UserPublic.fromMap(snap.data['firstUser'] as Map<String, dynamic>),
      secondUser:
          UserPublic.fromMap(snap.data['secondUser'] as Map<String, dynamic>),
      uids: List<String>.from(snap.data['uids'] as List<dynamic>),
      likedMap: Map<String, bool>.from(
          snap.data['likedMap'] as Map<dynamic, dynamic>),
      matchedAt:
          (snap.data['machedAt'] as Timestamp)?.toDate() ?? DateTime.now(),
      lastMessage:
          Message.fromMap(snap.data['lastMessage'] as Map<String, dynamic>),
    );
  }

  String get documentId {
    return '${uids.first}${uids[1]}';
  }

  /// return the userPublic that is not yourself
  UserPublic opponent(String uid) {
    if (firstUser.uid == uid) {
      return secondUser;
    } else {
      return firstUser;
    }
  }
}
