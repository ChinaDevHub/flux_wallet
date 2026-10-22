import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';

enum PasswordStatus { editing, saving, done, wrongPassword, failed }

/// Plain class: every outcome must be able to notify again.
class ChangePasswordState {
  const ChangePasswordState({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirm = '',
    this.status = PasswordStatus.editing,
  });

  final String oldPassword, newPassword, confirm;
  final PasswordStatus status;

  bool get newLongEnough => newPassword.length >= RegistrationInput.minPassword;
  bool get matches => newPassword == confirm;

  bool get canSubmit =>
      oldPassword.isNotEmpty &&
      newLongEnough &&
      matches &&
      status != PasswordStatus.saving;

  ChangePasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirm,
    PasswordStatus? status,
  }) => ChangePasswordState(
    oldPassword: oldPassword ?? this.oldPassword,
    newPassword: newPassword ?? this.newPassword,
    confirm: confirm ?? this.confirm,
    status: status ?? PasswordStatus.editing,
  );
}
