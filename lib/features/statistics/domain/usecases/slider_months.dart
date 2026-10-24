import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';

/// The months a range can be picked from: back to the first month with data,
/// but never fewer than [min] (a slider needs room) nor more than [max].
List<DateTime> sliderMonths(
  DateTime? firstData,
  DateTime today, {
  int min = 6,
  int max = 24,
}) {
  final now = monthStart(today);
  final first = monthStart(firstData ?? today);
  final shortest = DateTime(now.year, now.month - min + 1);
  final longest = DateTime(now.year, now.month - max + 1);
  final from = first.isAfter(shortest)
      ? shortest
      : first.isBefore(longest)
      ? longest
      : first;
  return StatsRange(from, now).months;
}
