import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';
import 'package:flux_wallet/features/rules/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// Plain class: a reload always repaints the screen.
class HomeSnapshot {
  const HomeSnapshot({
    required this.userName,
    required this.today,
    required this.limit,
    required this.dailyBudget,
    required this.spentToday,
    required this.todayTransactions,
    required this.todayPlans,
    required this.upcoming,
    required this.tip,
    this.pendingCount = 0,
    this.accounts = const [],
  });

  final String userName;
  final DateTime today;
  final DailyLimit limit;

  /// Today's limit as it was at the start of the day.
  final double dailyBudget;

  /// Discretionary spending today (debt payments excluded).
  final double spentToday;
  final List<Transaction> todayTransactions;
  final List<PlannedPayment> todayPlans;
  final List<PlannedPayment> upcoming;
  final DailyTip tip;

  /// Bank notifications waiting for "Təsdiqlə".
  final int pendingCount;

  /// Kart / Nağd, so each transaction can say where the money moved.
  final List<Account> accounts;

  double get remainingToday => dailyBudget - spentToday;

  /// 0..1 share of today's budget still available.
  double get remainingRatio =>
      dailyBudget <= 0 ? 0 : (remainingToday / dailyBudget).clamp(0.0, 1.0);
}
