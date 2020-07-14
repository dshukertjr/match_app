import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserPublic {
  const UserPublic({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.imageUrls,
    @required this.distance,
    @required this.createdAt,
  });

  final String uid;
  final String name;
  final String description;
  final List<String> imageUrls;
  final int distance;
  final DateTime createdAt;

  static UserPublic fromSnap(DocumentSnapshot snap) {
    return UserPublic(
      uid: snap.data['uid'] as String,
      name: snap.data['name'] as String,
      description: snap.data['description'] as String,
      imageUrls: List<String>.from(snap.data['imageUrls'] as List<dynamic>),
      distance: snap.data['distance'] as int,
      createdAt: (snap.data['createdAt'] as Timestamp).toDate(),
    );
  }
}
