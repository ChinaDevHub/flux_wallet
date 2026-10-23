import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_entries.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

List<TimelineDay> timelineDays({
  required DateTime month,
  required DateTime today,
  required ScheduleContext ctx,
  required Map<DateTime, double> ends,
  required Map<DateTime, List<Transaction>> transactions,
  required Map<DateTime, List<PlannedPayment>> plans,
  Map<int, String> accountNames = const {},
}) => [
  for (
    var d = monthStart(month);
    !d.isAfter(monthEnd(month));
    d = addDays(d, 1)
  )
    TimelineDay(
      date: d,
      entries: entriesFor(
        transactions[d] ?? const [],
        plans[d] ?? const [],
        accountNames: accountNames,
      ),
      endBalance: ends[d] ?? 0,
      isToday: d == today,
      isPast: d.isBefore(today),
      isDayOff: ctx.offDays.contains(d),
    ),
];
