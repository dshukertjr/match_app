import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SexualOrientation {
  static const String gay = 'gay';
  static const String lesbian = 'lesbian';
  static const String bisexual = 'bisexual';
  static const String transgender = 'transgender';
  static const String hide = 'hide';
}

class UserPrivate {
  const UserPrivate({
    @required this.uid,
    @required this.name,
    this.description,
    @required this.imageUrls,
    @required this.birthDate,
    @required this.sexualOrientation,
    @required this.wantSexualOrientation,
  })  : assert(uid != null),
        assert(name != null);

  final String uid;
  final String name;
  final String description;
  final List<String> imageUrls;
  final DateTime birthDate;
  final String sexualOrientation;
  final String wantSexualOrientation;

  static UserPrivate fromSnap(DocumentSnapshot snap) {
    if (!snap.exists) {
      return null;
    }
    return UserPrivate(
      uid: snap.data['uid'] as String,
      name: snap.data['name'] as String,
      description: snap.data['description'] as String,
      imageUrls: List<String>.from(
          (snap.data['imageUrls'] ?? <dynamic>[]) as List<dynamic>),
      birthDate: snap.data['birthDate'].toDate() as DateTime,
      sexualOrientation: snap.data['sexualOrientation'] as String,
      wantSexualOrientation: snap.data['wantSexualOrientation'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'birthDate': birthDate,
      'birth': <String, int>{
        'year': birthDate.year,
        'month': birthDate.month,
        'date': birthDate.day,
      },
      'sexualOrientation': sexualOrientation,
      'wantSexualOrientation': wantSexualOrientation,
    }..removeWhere((String key, dynamic value) => value == null);
  }
}
