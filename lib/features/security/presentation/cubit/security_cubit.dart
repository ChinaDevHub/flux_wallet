import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/security/domain/usecases/app_pin.dart';
import 'package:flux_wallet/features/security/domain/usecases/auto_lock.dart';
import 'package:flux_wallet/features/security/presentation/cubit/security_state.dart';

class SecurityCubit extends ReloadingCubit<SecurityState> {
  SecurityCubit(this._pin, this._autoLock, Stream<void> changes)
    : super(const SecurityState(), changes);

  final AppPin _pin;
  final AutoLock _autoLock;

  @override
  Future<void> load() async => emit(
    SecurityState(
      pinEnabled: await _pin.isSet(),
      pinLength: await _pin.length(),
      timeout: await _autoLock.read(),
    ),
  );

  /// The write triggers a reload; emitting first keeps the control snappy.
  Future<void> setTimeout(LockTimeout timeout) async {
    emit(
      SecurityState(
        pinEnabled: state.pinEnabled,
        pinLength: state.pinLength,
        timeout: timeout,
      ),
    );
    await _autoLock.write(timeout);
  }
}
