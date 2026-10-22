import 'package:flux_wallet/core/utils/az_names.dart';

String azDayMonth(DateTime d) => '${d.day} ${azMonths[d.month - 1]}';

String azFullDate(DateTime d) =>
    '${azWeekdays[d.weekday - 1]}, ${azDayMonth(d)}';

String azGreeting(int hour) => switch (hour) {
  < 5 => 'Gecən xeyir',
  < 12 => 'Sabahın xeyir',
  < 18 => 'Günün xeyir',
  _ => 'Axşamın xeyir',
};
