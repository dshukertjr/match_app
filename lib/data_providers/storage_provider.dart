import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageProvider {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadFile(
      {@required String path, @required File file}) async {
    final ref = _storage.ref().child(path);
    final task = ref.putFile(file);
    await task.onComplete;
    final downloadUrl = (await ref.getDownloadURL()) as String;
    return downloadUrl;
  }
}
