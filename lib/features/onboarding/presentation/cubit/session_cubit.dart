import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';

enum SessionState { loading, onboarding, ready }

/// Decides whether to show onboarding or the app.
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._profile) : super(SessionState.loading);

  final ProfileRepository _profile;

  Future<void> check() async {
    final name = await _profile.readName();
    emit(name == null ? SessionState.onboarding : SessionState.ready);
  }
}
