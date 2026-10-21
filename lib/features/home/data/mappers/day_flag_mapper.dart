import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/day_flag.dart';

extension DayFlagMapper on DayFlag {
  Map<String, Object?> toMap() => {
    'date': dayKey(date),
    'is_not_working_day': isNotWorkingDay ? 1 : 0,
  };
}
