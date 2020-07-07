import 'package:flutter/foundation.dart';

class SexualOrientation {
  static const gay = 'gay';
  static const lesbian = 'lesbian';
  static const bisexual = 'bisexual';
  static const transgender = 'transgender';
  static const hide = 'hide';
}

class Profile {
  final String uid;
  final String name;
  final String description;
  final String profileImageUrl;

  Profile({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.profileImageUrl,
  })  : assert(uid != null),
        assert(name != null);
}
