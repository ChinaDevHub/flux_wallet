import 'package:flux_wallet/features/rules/domain/entities/day_flag.dart';

abstract interface class DayFlagRepository {
  /// Days flagged as "not working" on or after [from].
  Future<Set<DateTime>> getOffDaysFrom(DateTime from);
  Future<void> set(DayFlag flag);
}
