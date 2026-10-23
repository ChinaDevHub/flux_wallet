import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';

/// The user's daily cap (null while unset), reloaded after every change.
class DailyCapCubit extends ReloadingCubit<double?> {
  DailyCapCubit(this._cap, Stream<void> changes) : super(null, changes);

  final DailyCap _cap;

  @override
  Future<void> load() async => emit(await _cap.read());

  Future<void> save(double amount) => _cap.write(amount);

  Future<void> clear() => _cap.clear();
}
