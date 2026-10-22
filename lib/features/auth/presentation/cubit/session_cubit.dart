import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';

/// Decides what the app shows: sign-in, first-time setup, or home. It follows
/// the database, so signing in/out or restoring a backup updates the screen.
class SessionCubit extends ReloadingCubit<SessionState> {
  SessionCubit(
    this._resolve,
    Stream<void> changes, {
    SessionState initial = SessionState.loading,
  }) : super(initial, changes);

  final ResolveSession _resolve;

  @override
  Future<void> load() async => emit(await _resolve());
}
