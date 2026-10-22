import 'package:flux_wallet/core/session/current_user.dart';

/// Builds the `user_id` part of every query, so a user's rows can never mix
/// with another's: `where`/`args` filter, `stamp` marks new rows.
class UserScope {
  const UserScope(this._user);

  final CurrentUser _user;

  String get id => _user.id;

  /// `user_id = ?`, optionally AND-ed with [extra] (whose arguments go first).
  String where([String? extra]) =>
      extra == null ? 'user_id = ?' : '($extra) AND user_id = ?';

  List<Object?> args([List<Object?> extra = const []]) => [...extra, id];

  Map<String, Object?> stamp(Map<String, Object?> row) => {
    ...row,
    'user_id': id,
  };
}
