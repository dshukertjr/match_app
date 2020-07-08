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
      'wantSexualOrientation':
    }..removeWhere((key, value) => value == null);
  }
}
