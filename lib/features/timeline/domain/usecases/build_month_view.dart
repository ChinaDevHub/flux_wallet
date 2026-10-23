import 'package:flux_wallet/features/timeline/domain/entities/month_frame.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/daily_limits.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/income_cycle_finder.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/lowest_forecast_day.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_balances.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_days.dart';

/// Balances, limits and days of one [MonthFrame], as the screen shows them.
TimelineView buildMonthView(MonthFrame f, {required MonthFrame shown}) {
  final ends = endBalances(f);
  final days = timelineDays(
    f,
    ends: ends,
    limits: dailyLimits(f, ends),
    shown: shown,
  );
  final cycle = const IncomeCycleFinder()(f.rules, f.today, f.ctx);
  return TimelineView(
    month: f.first,
    days: days,
    cycle: cycle,
    lowest: lowestForecastDay(days, f.today, cycle?.date),
  );
}
