import 'package:flux_wallet/features/budget/domain/usecases/daily_cap.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/home/domain/usecases/start_of_day_limit.dart';
import 'package:flux_wallet/features/timeline/domain/entities/day_limit.dart';
import 'package:flux_wallet/features/timeline/domain/entities/month_frame.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_list_x.dart';

/// How each past day (and today) of the month went against its limit.
///
/// A day's limit is worked out the way Home works out today's: the money at
/// the start of that day, less what was then planned until the next income,
/// spread over the days left. The rules keep their history (ended or paused
/// ones still count for the days they ran), so a change made today never
/// moves the limit of a day that is over. [ends] is the balance at the end
/// of each day.
Map<DateTime, DayLimit> dailyLimits(MonthFrame f, Map<DateTime, double> ends) {
  const calc = CalculateDailyLimit();
  final limits = <DateTime, DayLimit>{};
  for (final d in f.days.where((d) => !d.isAfter(f.today))) {
    final spent = f.transactionsOn(d).discretionaryExpense;
    final start = calc.atStartOfDay(
      balance: d == f.today ? f.balance : ends[d] ?? f.balance,
      spent: spent,
      rules: f.rules,
      today: d,
      ctx: f.ctx,
    );
    limits[d] = DayLimit(
      budget: DailyCap.effective(calc.perDay(start), f.cap),
      spent: spent,
    );
  }
  return limits;
}
