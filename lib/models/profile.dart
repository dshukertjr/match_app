import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SexualOrientation {
  static const gay = 'gay';
  static const lesbian = 'lesbian';
  static const bisexual = 'bisexual';
  static const transgender = 'transgender';
  static const hide = 'hide';
}

class UserPrivate {
  final String uid;
  final String name;
  final String description;
  final String profileImageUrl;
  final DateTime birthDate;
  final String sexualOrientation;
  final String wantSexualOrientation;

  UserPrivate({
    @required this.uid,
    @required this.name,
    this.description,
    @required this.profileImageUrl,
    @required this.birthDate,
    @required this.sexualOrientation,
    @required this.wantSexualOrientation,
  })  : assert(uid != null),
        assert(name != null);

  static UserPrivate fromSnap(DocumentSnapshot snap) {
    if (!snap.exists) {
      return null;
    }
    return UserPrivate(
      uid: snap.data['uid'],
      name: snap.data['name'],
      description: snap.data['description'],
      profileImageUrl: snap.data['profileImageUrl'],
      birthDate: snap.data['birthDate'].toDate(),
      sexualOrientation: snap.data['sexualOrientation'],
      wantSexualOrientation: snap.data['wantSexualOrientation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'profileImageUrl': profileImageUrl,
      'birthDate': birthDate,
      'birth': {
        'year': birthDate.year,
        'month': birthDate.month,
        'date': birthDate.day,
      },
      'sexualOrientation': sexualOrientation,
      'wantSexualOrientation': wantSexualOrientation,
    }..removeWhere((key, value) => value == null);
  }
}
