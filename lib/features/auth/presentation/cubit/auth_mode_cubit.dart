import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';

enum AuthMode { login, register }

/// Sign-in or create-account; a device with no accounts starts on register.
class AuthModeCubit extends Cubit<AuthMode> {
  AuthModeCubit(this._users) : super(AuthMode.login);

  final UserRepository _users;

  Future<void> load() async {
    if (await _users.count() == 0) emit(AuthMode.register);
  }

  void show(AuthMode mode) => emit(mode);
}
