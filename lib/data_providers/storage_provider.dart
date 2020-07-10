import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageProvider {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(
      {@required String path, @required File file}) async {
    final StorageReference ref = _storage.ref().child(path);
    final StorageUploadTask task = ref.putFile(file);
    await task.onComplete;
    final String downloadUrl = await ref.getDownloadURL() as String;
    return downloadUrl;
  }
}
