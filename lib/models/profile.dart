import 'package:flutter/foundation.dart';

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
