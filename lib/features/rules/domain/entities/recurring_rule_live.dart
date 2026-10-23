import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

extension RecurringRuleLive on RecurringRule {
  /// Still has days to come: not ended before [today]. An ended rule is
  /// history only and no longer listed.
  bool isLive(DateTime today) =>
      endDate == null || !dateOnly(endDate!).isBefore(dateOnly(today));

  /// A single planned payment: it ends on the day it starts.
  bool get isOneOff =>
      frequency == Frequency.monthly &&
      endDate != null &&
      dateOnly(endDate!) == dateOnly(startDate);

  /// Whether any of its days is already over.
  bool hasHistory(DateTime today) => dateOnly(startDate).isBefore(today);
}
