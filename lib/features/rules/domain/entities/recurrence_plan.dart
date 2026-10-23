import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/weekdays.dart';

/// Everything the "Təkrarla" section collects; it becomes a [RecurringRule]
/// (see `RecurrencePlanDraft`).
class RecurrencePlan extends Equatable {
  const RecurrencePlan({
    required this.frequency,
    required this.weekdays,
    this.skipMonths = const {},
    this.end = RecurrenceEnd.never,
  });

  /// The frequency's usual days, no paused months, no end.
  RecurrencePlan.of(Frequency f, DateTime start)
    : this(frequency: f, weekdays: Weekdays.defaultFor(f, start));

  /// A single payment on [day] (a monthly rule that ends where it starts).
  RecurrencePlan.once(DateTime day)
    : this(frequency: Frequency.monthly, weekdays: const {}, end: EndsOn(day));

  /// The plan a stored rule follows today.
  factory RecurrencePlan.fromRule(RecurringRule r) => RecurrencePlan(
    frequency: r.frequency,
    weekdays: r.activeWeekdays,
    skipMonths: r.skipMonths,
    end: r.endDate == null ? RecurrenceEnd.never : EndsOn(r.endDate!),
  );

  final Frequency frequency;
  final Set<int> weekdays;
  final Set<int> skipMonths;
  final RecurrenceEnd end;

  /// Monthly rules fall on the start date's day; the others pick weekdays.
  bool get picksDays => frequency != Frequency.monthly;

  bool get isValid => !picksDays || weekdays.isNotEmpty;

  @override
  List<Object?> get props => [frequency, weekdays, skipMonths, end];
}
