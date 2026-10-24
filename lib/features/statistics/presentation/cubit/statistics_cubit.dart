import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/domain/usecases/load_statistics.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_state.dart';

/// The statistics for a period: a ready-made one (last 1, 2, 3, 6 months)
/// or one picked on the slider, optionally narrowed to one month.
class StatisticsCubit extends ReloadingCubit<StatisticsState> {
  StatisticsCubit(this._load, this._clock, Stream<void> changes)
    : super(const StatisticsLoading(), changes);

  final LoadStatistics _load;
  final Clock _clock;
  StatsRange? _range;
  DateTime? _month;

  @override
  Future<void> load() async {
    try {
      emit(StatisticsLoaded(await _load(range: _range, month: _month)));
    } catch (_) {
      emit(const StatisticsFailure());
    }
  }

  Future<void> setPreset(StatsPreset p) =>
      setRange(StatsRange.last(p.months, _clock()));

  Future<void> setRange(StatsRange range) {
    _range = range;
    _month = null;
    return load();
  }

  /// Tapping a month in the chart narrows the breakdown to it; tapping it
  /// again goes back to the whole period.
  Future<void> select(DateTime month) {
    _month = _month == month ? null : month;
    return load();
  }
}
