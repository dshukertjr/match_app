import 'dart:io';

import 'package:flutter/foundation.dart';

class EditingProfileImage {
  const EditingProfileImage({
    this.imageUrl,
    this.imageFile,
  });

  final String imageUrl;
  final File imageFile;

  /// Creates List of EditingProfileImage from imageUrls property of userPrivate
  static List<EditingProfileImage> fromImageUrls(List<String> imageUrls) {
    final List<EditingProfileImage> editingProfileImages = imageUrls
        .map<EditingProfileImage>(
            (String imageUrl) => EditingProfileImage(imageUrl: imageUrl))
        .toList(growable: true);
    if (editingProfileImages.length < 6) {
      editingProfileImages.addAll(List<EditingProfileImage>.filled(
          6 - editingProfileImages.length, null));
    }
    return editingProfileImages;
  }

  static List<EditingProfileImage> addNewImage({
    @required List<EditingProfileImage> editingProfileImages,
    @required int updatingIndex,
    @required File newFile,
  }) {
    final List<EditingProfileImage> updatedEditingProfileImages =
        editingProfileImages;
    final EditingProfileImage targetEditingProfileImage =
        editingProfileImages[updatingIndex];
    if (targetEditingProfileImage == null) {
      /// if the tapped target was a blank image
      final int targetIndex = updatedEditingProfileImages.indexWhere(
          (EditingProfileImage editingProfileImage) =>
              editingProfileImage == null);
      updatedEditingProfileImages[targetIndex] =
          EditingProfileImage(imageFile: newFile);
    } else {
      updatedEditingProfileImages[updatingIndex] =
          EditingProfileImage(imageFile: newFile);
    }
    return updatedEditingProfileImages;
  }
}
