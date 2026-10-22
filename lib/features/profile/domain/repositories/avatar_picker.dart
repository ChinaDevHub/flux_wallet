abstract interface class AvatarPicker {
  /// Lets the user choose a photo; returns the stored avatar value
  /// (`file:<name>`), or null when they cancelled.
  Future<String?> pickFromGallery(String userId);

  /// Deletes the stored photo behind [avatarUrl] (no-op for presets).
  Future<void> discard(String avatarUrl);
}
