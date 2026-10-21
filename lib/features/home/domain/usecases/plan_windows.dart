import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/usecases/plan_builder.dart';

/// The two windows the home screen cares about.
extension PlanWindows on PlanBuilder {
  /// Mandatory payments planned for today (shown in the "Bu gün" list).
  List<PlannedPayment> today(
    List<RecurringRule> rules,
    DateTime today,
    Set<DateTime> offDays,
  ) => this(
    rules,
    from: today,
    to: today,
    offDays: offDays,
    filter: (r) => !r.isIncome,
  );

  /// Monthly bills and income within the next [days] days ("Qarşıda").
  List<PlannedPayment> upcoming(
    List<RecurringRule> rules,
    DateTime today,
    Set<DateTime> offDays, {
    int days = 14,
  }) => this(
    rules,
    from: addDays(today, 1),
    to: addDays(today, days),
    offDays: offDays,
    filter: (r) => r.frequency == Frequency.monthly,
  );
}
