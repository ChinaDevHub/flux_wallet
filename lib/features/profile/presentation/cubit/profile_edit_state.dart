import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/domain/entities/profile_edit.dart';

enum ProfileSaveStatus { idle, saving, saved, usernameTaken, failed }

/// Plain class: every save outcome must be able to notify again.
class ProfileEditState {
  const ProfileEditState({
    required this.saved,
    required this.fullName,
    required this.username,
    required this.hint,
    this.status = ProfileSaveStatus.idle,
  });

  factory ProfileEditState.from(User user) => ProfileEditState(
    saved: user,
    fullName: user.fullName,
    username: user.username,
    hint: user.passwordHint ?? '',
  );

  /// The user as last stored.
  final User saved;
  final String fullName, username, hint;
  final ProfileSaveStatus status;

  ProfileEdit get edit =>
      ProfileEdit(fullName: fullName, username: username, hint: hint);

  bool get changed => edit.differsFrom(saved);

  bool get canSave =>
      edit.isValid && changed && status != ProfileSaveStatus.saving;

  ProfileEditState copyWith({
    User? saved,
    String? fullName,
    String? username,
    String? hint,
    ProfileSaveStatus? status,
  }) => ProfileEditState(
    saved: saved ?? this.saved,
    fullName: fullName ?? this.fullName,
    username: username ?? this.username,
    hint: hint ?? this.hint,
    status: status ?? ProfileSaveStatus.idle,
  );
}
