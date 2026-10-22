import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/load_statistics.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_state.dart';

class StatisticsCubit extends ReloadingCubit<StatisticsState> {
  StatisticsCubit(this._load, Stream<void> changes)
    : super(const StatisticsLoading(), changes);

  final LoadStatistics _load;
  DateTime? _selected;

  @override
  Future<void> load() async {
    try {
      emit(StatisticsLoaded(await _load(_selected)));
    } catch (_) {
      emit(const StatisticsFailure());
    }
  }

  /// Tapping a month in the chart re-targets the category breakdown.
  Future<void> select(DateTime month) {
    _selected = month;
    return load();
  }
}
