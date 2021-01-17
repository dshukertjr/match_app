import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageType {
  static const String text = 'text';
  static const String image = 'image';
}

class Message {
  const Message({
    @required this.type,
    this.text,
    this.imageUrl,
    @required this.uid,
    @required this.matchPairId,
    @required this.createdAt,
  })  : assert(type != null),
        assert(type == MessageType.text || type == MessageType.image);

  /// MessageType type of message
  final String type;

  /// text sent with the message
  final String text;

  /// imageUrl of the image send as a message
  final String imageUrl;

  /// uid of the user who posted this message
  final String uid;

  /// documentId of the matchPair of this message
  final String matchPairId;

  /// time when the message was created
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'text': text,
      'imageUrl': imageUrl,
      'uid': uid,
      'matchPairId': matchPairId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Message(
      type: map['type'] as String,
      text: map['text'] as String,
      imageUrl: map['imageUrl'] as String,
      uid: map['uid'] as String,
      matchPairId: map['matchPairId'] as String,
      createdAt: (map['createdAt'] as Timestamp)?.toDate() ?? DateTime.now(),
    );
  }

  bool isSentByYou(String uid) {
    return uid == this.uid;
  }

  String get getMessageLabel {
    if (text != null) {
      return text;
    } else {
      return '画像を送信しました';
    }
  }
}
