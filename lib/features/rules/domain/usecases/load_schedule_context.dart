import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/repositories/day_flag_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_exception_repository.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_pause_repository.dart';

class LoadScheduleContext {
  const LoadScheduleContext(this._dayFlags, this._exceptions, this._pauses);

  final DayFlagRepository _dayFlags;
  final RuleExceptionRepository _exceptions;
  final RulePauseRepository _pauses;

  /// Day flags, skips and pauses from [from] on.
  Future<ScheduleContext> call(DateTime from) async => ScheduleContext(
    offDays: await _dayFlags.getOffDaysFrom(from),
    exceptions: await _exceptions.getFrom(from),
    pauses: await _pauses.getFrom(from),
  );
}
