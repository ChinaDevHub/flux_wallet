import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/repositories/recurring_rule_repository.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/build_timeline.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

class LoadTimeline {
  const LoadTimeline({
    required this.accounts,
    required this.transactions,
    required this.rules,
    required this.schedule,
    required this.clock,
  });

  final AccountRepository accounts;
  final TransactionRepository transactions;
  final RecurringRuleRepository rules;
  final LoadScheduleContext schedule;
  final Clock clock;

  /// [monthOffset] 0 = current month, 1 = next month.
  Future<TimelineView> call(int monthOffset) async {
    final today = dateOnly(clock());
    final month = DateTime(today.year, today.month + monthOffset);
    final all = await accounts.getAll();
    return const BuildTimeline()(
      today: today,
      month: month,
      balance: all.fold(0.0, (sum, a) => sum + a.balance),
      rules: await rules.getActive(),
      ctx: await schedule(today),
      transactions: await transactions.getBetween(
        DateTime(today.year, today.month),
        addDays(today, 1),
      ),
    );
  }
}
