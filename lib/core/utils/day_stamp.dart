import 'package:flux_wallet/core/utils/date_utils.dart';

/// A day the user picked, as the moment to store: today keeps the real time,
/// any other day is pinned to noon (so it never slips across midnight).
DateTime stampDay(DateTime day, DateTime now) {
  final picked = dateOnly(day);
  return picked == dateOnly(now) ? now : picked.add(const Duration(hours: 12));
}
