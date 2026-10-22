import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';
import 'package:flux_wallet/features/profile/domain/usecases/update_profile.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit(User user, this._update)
    : super(ProfileEditState.from(user));

  final UpdateProfile _update;

  void setFullName(String v) => emit(state.copyWith(fullName: v));
  void setUsername(String v) => emit(state.copyWith(username: v));
  void setHint(String v) => emit(state.copyWith(hint: v));

  Future<void> save() async {
    if (!state.canSave) return;
    final s = state;
    emit(s.copyWith(status: ProfileSaveStatus.saving));
    try {
      final user = await _update(s.edit);
      emit(
        ProfileEditState.from(user).copyWith(status: ProfileSaveStatus.saved),
      );
    } on AuthException catch (e) {
      emit(
        s.copyWith(
          status: e.failure == AuthFailure.usernameTaken
              ? ProfileSaveStatus.usernameTaken
              : ProfileSaveStatus.failed,
        ),
      );
    } catch (_) {
      emit(s.copyWith(status: ProfileSaveStatus.failed));
    }
  }
}
