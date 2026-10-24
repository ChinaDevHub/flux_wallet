import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';

/// How today is going, from calm to alarming.
enum LimitStatus {
  /// Spending is well inside today's limit.
  calm,

  /// Most of today's limit is used up.
  careful,

  /// Today's limit is spent and more.
  over,

  /// The money cannot even cover what must be paid before the next income.
  shortfall,
}

extension HomeSnapshotStatus on HomeSnapshot {
  /// From this share of the day's limit on, the day turns "careful".
  static const carefulShare = 0.8;

  LimitStatus get status {
    if (limit.hasShortfall) return LimitStatus.shortfall;
    if (remainingToday < 0) return LimitStatus.over;
    final used = dailyBudget <= 0 ? 0 : spentToday / dailyBudget;
    return used >= carefulShare ? LimitStatus.careful : LimitStatus.calm;
  }
}
