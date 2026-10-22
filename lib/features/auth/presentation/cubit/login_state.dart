enum LoginStatus { idle, loading, failed }

/// Plain class: each failed attempt must be able to notify again.
class LoginState {
  const LoginState({
    this.username = '',
    this.password = '',
    this.status = LoginStatus.idle,
  });

  final String username, password;
  final LoginStatus status;

  bool get canSubmit =>
      username.trim().isNotEmpty &&
      password.isNotEmpty &&
      status != LoginStatus.loading;

  /// The "Şifrə xatırlatması" button appears once a login failed.
  bool get offersHint => status == LoginStatus.failed;

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
  }) => LoginState(
    username: username ?? this.username,
    password: password ?? this.password,
    status: status ?? this.status,
  );
}
