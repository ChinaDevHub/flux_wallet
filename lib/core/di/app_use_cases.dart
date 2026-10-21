import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/rules/domain/usecases/create_rule_from_transaction.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/load_timeline.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';

/// Use cases wired to the data layer.
class AppUseCases {
  AppUseCases(this._repos, this._clock);

  final AppRepositories _repos;
  final Clock _clock;

  late final loadSchedule = LoadScheduleContext(
    _repos.dayFlags,
    _repos.exceptions,
  );
  late final scheduleEditor = RuleScheduleEditor(
    _repos.rules,
    _repos.exceptions,
    _repos.dayFlags,
  );
  late final addTransaction = AddTransaction(
    _repos.transactions,
    CreateRuleFromTransaction(_repos.rules, _repos.exceptions),
    _clock,
  );
  late final loadTimeline = LoadTimeline(
    accounts: _repos.accounts,
    transactions: _repos.transactions,
    rules: _repos.rules,
    schedule: loadSchedule,
    clock: _clock,
  );
  late final loadHome = LoadHomeSnapshot(
    profile: _repos.profile,
    accounts: _repos.accounts,
    transactions: _repos.transactions,
    rules: _repos.rules,
    schedule: loadSchedule,
    clock: _clock,
  );
}
