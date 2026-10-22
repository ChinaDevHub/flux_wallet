import 'package:flux_wallet/features/auth/domain/entities/user_copy.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/profile/domain/repositories/avatar_picker.dart';

class SetAvatar {
  const SetAvatar(this._users, this._picker);

  final UserRepository _users;
  final AvatarPicker _picker;

  /// A built-in preset or an already stored photo (`preset:2`, `file:x.jpg`).
  Future<void> call(String avatarUrl) async {
    final user = await _users.current();
    if (user == null) return;
    await _users.update(user.copyWith(avatarUrl: avatarUrl));
    final old = user.avatarUrl;
    if (old != null && old != avatarUrl) await _picker.discard(old);
  }

  /// Opens the gallery; false when the user cancelled.
  Future<bool> pickPhoto() async {
    final user = await _users.current();
    final stored = user == null ? null : await _picker.pickFromGallery(user.id);
    if (stored == null) return false;
    await call(stored);
    return true;
  }
}
