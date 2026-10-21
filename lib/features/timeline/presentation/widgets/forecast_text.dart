import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';

String forecastText(TimelineView view) {
  final low = view.lowest;
  if (low == null) return 'Proqnoz üçün bu ayda növbəti gün qalmayıb.';
  final date = azDayMonth(low.date);
  if (low.endBalance < 0) {
    return '$date tarixində balansın ${formatAzn(-low.endBalance)} '
        'mənfiyə düşəcək. Həmin günün ödənişlərini yenidən planlaşdır.';
  }
  final reach = view.cycle == null
      ? ''
      : ' Gündəlik limitə əməl etsən, ${view.cycle!.title} gününə çatacaqsan.';
  return 'Ən aşağı balans $date tarixində ${formatAzn(low.endBalance)} '
      'olacaq.$reach';
}
