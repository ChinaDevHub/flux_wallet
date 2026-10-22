import 'package:flux_wallet/features/auth/presentation/cubit/register_state.dart';

/// Field messages: shown only for fields the user has started typing in.
class RegisterErrors {
  const RegisterErrors(this._s);

  final RegisterState _s;

  String? get fullName => _s.fullName.isNotEmpty && !_s.input.fullNameOk
      ? 'Ad ən azı 2 simvol olmalıdır'
      : null;

  String? get username {
    final taken = _s.status == RegisterStatus.usernameTaken;
    if (taken) return 'Bu istifadəçi adı artıq mövcuddur';
    final fine = _s.username.isEmpty || _s.input.usernameOk;
    return fine ? null : '3-24 simvol: hərf, rəqəm, nöqtə və ya alt xətt';
  }

  String? get password => _s.password.isNotEmpty && !_s.input.passwordOk
      ? 'Şifrə çox qısadır'
      : null;

  String? get hint => _s.hint.isNotEmpty && !_s.input.hintOk
      ? 'Xatırlatma şifrənin özünü ehtiva etməməlidir'
      : null;

  String? get general => _s.status == RegisterStatus.failed
      ? 'Qeydiyyat alınmadı. Yenidən cəhd et.'
      : null;
}
