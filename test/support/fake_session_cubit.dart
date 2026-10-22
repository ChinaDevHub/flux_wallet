import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/auth/domain/usecases/resolve_session.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/session_cubit.dart';

/// A [SessionCubit] whose state the test sets directly.
class FakeSessionCubit extends Cubit<SessionState> implements SessionCubit {
  FakeSessionCubit([super.state = SessionState.loading]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
