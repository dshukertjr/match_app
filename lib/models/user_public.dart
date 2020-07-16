import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserPublic {
  const UserPublic({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.imageUrls,
    @required this.createdAt,
  });

  final String uid;
  final String name;
  final String description;
  final List<String> imageUrls;
  final DateTime createdAt;

  static UserPublic fromSnap(DocumentSnapshot snap) {
    return UserPublic(
      uid: snap.data['uid'] as String,
      name: snap.data['name'] as String,
      description: snap.data['description'] as String,
      imageUrls: List<String>.from(snap.data['imageUrls'] as List<dynamic>),
      createdAt: (snap.data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  static UserPublic fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return UserPublic(
      uid: map['uid'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List<dynamic>),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
