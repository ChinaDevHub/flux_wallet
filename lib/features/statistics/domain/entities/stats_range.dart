import 'package:equatable/equatable.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// The ready-made periods: the last 1, 2, 3 or 6 months.
enum StatsPreset {
  one(1, '1 ay'),
  two(2, '2 ay'),
  three(3, '3 ay'),
  six(6, '6 ay');

  const StatsPreset(this.months, this.label);

  final int months;
  final String label;
}

/// The months the statistics cover, [from] to [to] inclusive (first days).
class StatsRange extends Equatable {
  StatsRange(DateTime from, DateTime to)
    : from = monthStart(from),
      to = monthStart(to);

  /// The last [months] months, this one included.
  factory StatsRange.last(int months, DateTime today) =>
      StatsRange(DateTime(today.year, today.month - months + 1), today);

  final DateTime from, to;

  List<DateTime> get months => [
    for (var m = from; !m.isAfter(to); m = DateTime(m.year, m.month + 1)) m,
  ];

  bool contains(DateTime day) {
    final m = monthStart(day);
    return !m.isBefore(from) && !m.isAfter(to);
  }

  /// The preset this range is, if it is one.
  StatsPreset? presetAt(DateTime today) {
    if (to != monthStart(today)) return null;
    final n = months.length;
    return StatsPreset.values.where((p) => p.months == n).firstOrNull;
  }

  @override
  List<Object?> get props => [from, to];
}
