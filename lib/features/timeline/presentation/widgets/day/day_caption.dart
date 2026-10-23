import 'package:flux_wallet/core/utils/date_utils.dart';

/// "Bu gün", "Sabah", "3 gün sonra", "2 gün əvvəl".
String dayCaption(DateTime day, DateTime today) {
  final n = daysBetween(dateOnly(today), dateOnly(day));
  return switch (n) {
    0 => 'Bu gün',
    1 => 'Sabah',
    -1 => 'Dünən',
    > 1 => '$n gün sonra',
    _ => '${-n} gün əvvəl',
  };
}
