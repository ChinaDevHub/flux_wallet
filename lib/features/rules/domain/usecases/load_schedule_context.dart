import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/repositories/day_flag_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';

class LoadScheduleContext {
  const LoadScheduleContext(this._dayFlags, this._exceptions);

  final DayFlagRepository _dayFlags;
  final RuleExceptionRepository _exceptions;

  Future<ScheduleContext> call(DateTime from) async => ScheduleContext(
    offDays: await _dayFlags.getOffDaysFrom(from),
    exceptions: await _exceptions.getFrom(from),
  );
}
