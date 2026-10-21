import 'package:flux_wallet/features/home/domain/entities/daily_limit.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';

class GenerateDailyTip {
  const GenerateDailyTip();

  DailyTip call({required DailyLimit limit, required double remainingToday}) {
    if (limit.hasShortfall) return DailyTip(TipKind.shortfall, limit.shortfall);
    final spreadDays = limit.daysLeft - 1;
    if (spreadDays < 1) return const DailyTip(TipKind.onTrack);
    if (remainingToday < 0) {
      return DailyTip(TipKind.overspent, -remainingToday / spreadDays);
    }
    if (remainingToday > 0) {
      return DailyTip(TipKind.saving, remainingToday / spreadDays);
    }
    return const DailyTip(TipKind.onTrack);
  }
}
