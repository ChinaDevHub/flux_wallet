/// How a day of the grid is drawn.
class DayMarks {
  const DayMarks({
    required this.selected,
    required this.today,
    required this.enabled,
    required this.over,
  });

  final bool selected, today, enabled;

  /// The day went over its limit: a red dot under the number.
  final bool over;
}
