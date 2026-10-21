import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';
import 'package:flux_wallet/features/home/domain/entities/planned_payment.dart';
import 'package:flux_wallet/features/home/domain/entities/transaction.dart';

class HomeSnapshot extends Equatable {
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
  });

  final String userName;
  final DateTime today;
  final DailyLimit limit;

  /// Today's limit as it was at the start of the day.
  final double dailyBudget;
  final double spentToday;
  final List<Transaction> todayTransactions;
  final List<PlannedPayment> todayPlans;
  final List<PlannedPayment> upcoming;
  final DailyTip tip;

  double get remainingToday => dailyBudget - spentToday;

  /// 0..1 share of today's budget still available.
  double get remainingRatio =>
      dailyBudget <= 0 ? 0 : (remainingToday / dailyBudget).clamp(0.0, 1.0);

  @override
  List<Object?> get props => [
    userName,
    today,
    limit,
    dailyBudget,
    spentToday,
    todayTransactions,
    todayPlans,
    upcoming,
    tip,
  ];
}
