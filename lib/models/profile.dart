import 'package:flutter/foundation.dart';

class SexualOrientation {
  final bool maleG;
  final bool maleB;
  final bool maleT;
  final bool femaleL;
  final bool femaleB;
  final bool femaleT;
  final bool hide;

  SexualOrientation({
    @required this.maleG,
    @required this.maleB,
    @required this.maleT,
    @required this.femaleL,
    @required this.femaleB,
    @required this.femaleT,
    @required this.hide,
  });

  static SexualOrientation blank() {
    return SexualOrientation(
      maleG: false,
      maleB: false,
      maleT: false,
      femaleL: false,
      femaleB: false,
      femaleT: false,
      hide: false,
    );
  }

  SexualOrientation copyWith({
    bool maleG,
    bool maleB,
    bool maleT,
    bool femaleL,
    bool femaleB,
    bool femaleT,
    bool hide,
  }) {
    return SexualOrientation(
      maleG: maleG ?? this.maleG,
      maleB: maleB ?? this.maleB,
      maleT: maleT ?? this.maleT,
      femaleL: femaleL ?? this.femaleL,
      femaleB: femaleB ?? this.femaleB,
      femaleT: femaleT ?? this.femaleT,
      hide: hide ?? this.hide,
    );
  }
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
