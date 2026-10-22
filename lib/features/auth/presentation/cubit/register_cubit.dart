import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/usecases/register_user.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._register) : super(const RegisterState());

  final RegisterUser _register;

  void setFullName(String v) => emit(state.copyWith(fullName: v));
  void setUsername(String v) => emit(state.copyWith(username: v));
  void setPassword(String v) => emit(state.copyWith(password: v));
  void setHint(String v) => emit(state.copyWith(hint: v));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: RegisterStatus.loading));
    try {
      await _register(s.input);
    } on AuthException catch (e) {
      emit(
        s.copyWith(
          status: e.failure == AuthFailure.usernameTaken
              ? RegisterStatus.usernameTaken
              : RegisterStatus.failed,
        ),
      );
    } catch (_) {
      emit(s.copyWith(status: RegisterStatus.failed));
    }
  }
}
