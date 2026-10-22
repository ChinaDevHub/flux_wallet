import 'package:flux_wallet/core/session/session.dart';

/// Forgets the active user; the login screen takes over.
class LogoutUser {
  const LogoutUser(this._session);

  final Session _session;

  Future<void> call() => _session.signOut();
}
