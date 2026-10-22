import 'dart:io';

import 'package:flux_wallet/core/files/app_files.dart';
import 'package:flux_wallet/features/profile/domain/entities/avatar.dart';
import 'package:flux_wallet/features/profile/domain/repositories/avatar_picker.dart';
import 'package:image_picker/image_picker.dart';

/// Picks a photo with the system gallery and keeps a small copy in the app's
/// own folder, so it survives the original being deleted.
class GalleryAvatarPicker implements AvatarPicker {
  const GalleryAvatarPicker();

  @override
  Future<String?> pickFromGallery(String userId) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return null;
    final name = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(picked.path).copy(AppFiles.avatar(name).path);
    return Avatar.file(name);
  }

  @override
  Future<void> discard(String avatarUrl) async {
    final name = Avatar.fileName(avatarUrl);
    if (name == null) return;
    final file = AppFiles.avatar(name);
    if (await file.exists()) await file.delete();
  }
}
