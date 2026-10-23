import 'package:flux_wallet/features/rules/domain/entities/pause_range.dart';

abstract interface class RulePauseRepository {
  /// ruleId -> the pauses that cover any day on or after [from].
  Future<Map<int, List<PauseRange>>> getFrom(DateTime from);
}
