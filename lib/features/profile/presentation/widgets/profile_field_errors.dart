import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_state.dart';

class ProfileFieldErrors {
  const ProfileFieldErrors(this._s);

  final ProfileEditState _s;

  String? get fullName =>
      _s.edit.fullNameOk ? null : 'Ad ən azı 2 simvol olmalıdır';

  String? get username {
    final taken = _s.status == ProfileSaveStatus.usernameTaken;
    if (taken) return 'Bu istifadəçi adı artıq mövcuddur';
    return _s.edit.usernameOk
        ? null
        : '3-24 simvol: hərf, rəqəm, nöqtə və ya alt xətt';
  }
}
