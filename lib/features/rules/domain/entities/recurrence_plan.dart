import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/weekdays.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Everything the "Təkrarla" section collects; it becomes a [RecurringRule].
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

  final Frequency frequency;
  final Set<int> weekdays;
  final Set<int> skipMonths;
  final RecurrenceEnd end;

  /// Monthly rules fall on the start date's day; the others pick weekdays.
  bool get picksDays => frequency != Frequency.monthly;

  bool get isValid => !picksDays || weekdays.isNotEmpty;

  /// The rule this plan describes, before its end date is resolved.
  RecurringRule draft({
    required String title,
    required double amount,
    required String category,
    required DateTime start,
    TxType type = TxType.expense,
  }) => RecurringRule(
    title: title,
    amount: amount,
    category: category,
    frequency: frequency,
    startDate: start,
    type: type,
    weekdays: picksDays ? weekdays : null,
    skipMonths: skipMonths,
  );

  @override
  List<Object?> get props => [frequency, weekdays, skipMonths, end];
}
