import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/auth/domain/usecases/logout_user.dart';
import 'package:flux_wallet/features/profile/domain/entities/avatar.dart';
import 'package:flux_wallet/features/profile/domain/usecases/set_avatar.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_state.dart';

/// The signed-in user; reloads whenever the database changes.
class ProfileCubit extends ReloadingCubit<ProfileState> {
  ProfileCubit(this._users, this._setAvatar, this._logout, Stream<void> changes)
    : super(const ProfileState(), changes);

  final UserRepository _users;
  final SetAvatar _setAvatar;
  final LogoutUser _logout;

  @override
  Future<void> load() async => emit(ProfileState(await _users.current()));

  Future<void> choosePreset(int index) => _setAvatar(Avatar.preset(index));

  /// False when the user cancelled the gallery.
  Future<bool> choosePhoto() => _setAvatar.pickPhoto();

  Future<void> logout() => _logout();
}
