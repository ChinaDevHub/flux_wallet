import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/usecases/get_password_hint.dart';
import 'package:flux_wallet/features/auth/domain/usecases/login_user.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_state.dart';

/// Signing in updates the session, which switches the screen by itself.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._login, this._hint) : super(const LoginState());

  final LoginUser _login;
  final GetPasswordHint _hint;

  void setUsername(String v) => emit(state.copyWith(username: v));
  void setPassword(String v) => emit(state.copyWith(password: v));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: LoginStatus.loading));
    try {
      await _login(s.username, s.password);
    } catch (_) {
      emit(s.copyWith(status: LoginStatus.failed));
    }
  }

  Future<String?> hint() => _hint(state.username);
}
