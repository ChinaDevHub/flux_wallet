import 'package:flux_wallet/core/session/session.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/onboarding_repository.dart';

enum SessionState { loading, signedOut, onboarding, ready }

/// Where the app should be right now: sign-in, first-time setup, or home.
class ResolveSession {
  const ResolveSession(this._session, this._users, this._onboarding);

  final Session _session;
  final UserRepository _users;
  final OnboardingRepository _onboarding;

  Future<SessionState> call() async {
    final id = _session.activeId ?? await _session.restore();
    if (id == null || await _users.byId(id) == null) {
      // A stored id of a user that no longer exists is dropped.
      if (id != null) await _session.signOut();
      return SessionState.signedOut;
    }
    return await _onboarding.isCompleted()
        ? SessionState.ready
        : SessionState.onboarding;
  }
}
