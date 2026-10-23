import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';

/// The three ways a plan can end, as the segmented control offers them.
enum EndKind {
  never('Bitmir'),
  count('N dəfə'),
  date('Tarixə qədər');

  const EndKind(this.label);

  final String label;

  static EndKind of(RecurrenceEnd end) => switch (end) {
    NeverEnds() => never,
    EndsAfter() => count,
    EndsOn() => date,
  };

  /// A sensible starting value when the user switches to this kind.
  RecurrenceEnd defaultFor(DateTime start) => switch (this) {
    never => RecurrenceEnd.never,
    count => const EndsAfter(4),
    date => EndsOn(DateTime(start.year, start.month + 3, start.day)),
  };
}
