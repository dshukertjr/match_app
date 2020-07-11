import 'dart:io';

class EditingProfileImage {
  const EditingProfileImage({
    this.imageUrl,
    this.newImageFile,
  });

  final String imageUrl;
  final File newImageFile;

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
}
