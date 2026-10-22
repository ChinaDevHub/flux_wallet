import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/profile/domain/usecases/change_password.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._change) : super(const ChangePasswordState());

  final ChangePassword _change;

  void setOld(String v) => emit(state.copyWith(oldPassword: v));
  void setNew(String v) => emit(state.copyWith(newPassword: v));
  void setConfirm(String v) => emit(state.copyWith(confirm: v));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    final s = state;
    emit(s.copyWith(status: PasswordStatus.saving));
    try {
      await _change(s.oldPassword, s.newPassword);
      emit(s.copyWith(status: PasswordStatus.done));
    } on AuthException catch (e) {
      emit(
        s.copyWith(
          status: e.failure == AuthFailure.wrongPassword
              ? PasswordStatus.wrongPassword
              : PasswordStatus.failed,
        ),
      );
    } catch (_) {
      emit(s.copyWith(status: PasswordStatus.failed));
    }
  }
}
