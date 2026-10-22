import 'package:flux_wallet/core/di/use_cases/auth_use_cases.dart';
import 'package:flux_wallet/features/profile/domain/repositories/avatar_picker.dart';
import 'package:flux_wallet/features/profile/domain/usecases/change_password.dart';
import 'package:flux_wallet/features/profile/domain/usecases/set_avatar.dart';
import 'package:flux_wallet/features/profile/domain/usecases/update_profile.dart';

/// Editing the signed-in user's own account.
mixin ProfileUseCases on AuthUseCases {
  AvatarPicker get avatarPicker;

  late final updateProfile = UpdateProfile(repos.users);
  late final changePassword = ChangePassword(repos.users, hasher);
  late final setAvatar = SetAvatar(repos.users, avatarPicker);
}
