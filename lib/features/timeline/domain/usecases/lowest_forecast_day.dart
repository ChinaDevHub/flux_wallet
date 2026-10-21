import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

/// The day with the smallest balance from [today] until the [nextIncome].
TimelineDay? lowestForecastDay(
  List<TimelineDay> days,
  DateTime today,
  DateTime? nextIncome,
) {
  final window = days.where(
    (d) =>
        !d.date.isBefore(today) &&
        (nextIncome == null || d.date.isBefore(nextIncome)),
  );
  if (window.isEmpty) return null;
  return window.reduce((a, b) => b.endBalance < a.endBalance ? b : a);
}
