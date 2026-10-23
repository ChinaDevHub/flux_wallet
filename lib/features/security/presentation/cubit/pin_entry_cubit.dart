import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_state.dart';

/// Collects digits; it knows nothing about what the PIN is for.
class PinEntryCubit extends Cubit<PinEntryState> {
  PinEntryCubit(int length) : super(PinEntryState(length: length));

  void add(int digit) {
    if (state.isComplete) return;
    emit(PinEntryState(length: state.length, digits: '${state.digits}$digit'));
  }

  void backspace() {
    if (state.isEmpty) return;
    final d = state.digits;
    emit(
      PinEntryState(length: state.length, digits: d.substring(0, d.length - 1)),
    );
  }

  void clear() => emit(PinEntryState(length: state.length));
}
