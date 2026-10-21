import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// A cubit that calls [load] again whenever the database changes.
abstract class ReloadingCubit<S> extends Cubit<S> {
  ReloadingCubit(super.initialState, Stream<void> changes) {
    _subscription = changes.listen((_) => load());
  }

  late final StreamSubscription<void> _subscription;

  Future<void> load();

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
