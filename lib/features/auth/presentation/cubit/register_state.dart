import 'package:flux_wallet/features/auth/domain/usecases/registration_input.dart';

enum RegisterStatus { editing, loading, usernameTaken, failed }

/// Plain class: each failure must be able to notify again.
class RegisterState {
  const RegisterState({
    this.fullName = '',
    this.username = '',
    this.password = '',
    this.hint = '',
    this.status = RegisterStatus.editing,
  });

  final String fullName, username, password, hint;
  final RegisterStatus status;

  RegistrationInput get input => RegistrationInput(
    fullName: fullName,
    username: username,
    password: password,
    hint: hint,
  );

  bool get canSubmit => input.isValid && status != RegisterStatus.loading;

  RegisterState copyWith({
    String? fullName,
    String? username,
    String? password,
    String? hint,
    RegisterStatus? status,
  }) => RegisterState(
    fullName: fullName ?? this.fullName,
    username: username ?? this.username,
    password: password ?? this.password,
    hint: hint ?? this.hint,
    status: status ?? RegisterStatus.editing,
  );
}
