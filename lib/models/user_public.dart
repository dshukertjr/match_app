import 'package:flutter/foundation.dart';

class UserPublic {
  const UserPublic({
    @required this.name,
    @required this.description,
    @required this.imageUrls,
    @required this.distance,
  });

  final String name;
  final String description;
  final List<String> imageUrls;
  final int distance;
}
