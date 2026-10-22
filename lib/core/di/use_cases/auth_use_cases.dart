import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/usecases/get_password_hint.dart';
import 'package:flux_wallet/features/auth/domain/usecases/login_user.dart';
import 'package:flux_wallet/features/auth/domain/usecases/logout_user.dart';
import 'package:flux_wallet/features/auth/domain/usecases/register_user.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';

/// Register, sign in/out and "where should the app be".
mixin AuthUseCases on UseCaseDeps {
  PasswordHasher get hasher;

  late final registerUser = RegisterUser(repos.users, hasher, session);
  late final loginUser = LoginUser(repos.users, hasher, session);
  late final logoutUser = LogoutUser(session);
  late final passwordHint = GetPasswordHint(repos.users);
  late final resolveSession = ResolveSession(
    session,
    repos.users,
    repos.onboarding,
  );
}
