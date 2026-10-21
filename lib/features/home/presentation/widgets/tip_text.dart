import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/home/domain/entities/daily_tip.dart';

String tipText(DailyTip tip) {
  final amount = '${formatMoney(tip.amount)} $azn';
  return switch (tip.kind) {
    TipKind.shortfall =>
      'Məcburi xərcləri ödəmək üçün $amount çatışmır. '
          'Gəlir və ya xərc planını yenidən nəzərdən keçir.',
    TipKind.overspent =>
      'Bugünkü limiti aşdın. Qalan günlərdə gündəlik '
          'büdcəni təxminən $amount azaltmaq lazım olacaq.',
    TipKind.saving =>
      'Bugünkü qənaətiniz maaş gününə qədər gündəlik '
          'büdcənizi +$amount artıra bilər.',
    TipKind.onTrack => 'Büdcə planına uyğun gedirsən. Belə davam et!',
  };
}
