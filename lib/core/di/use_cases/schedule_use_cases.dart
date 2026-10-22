import 'package:flux_wallet/core/di/use_cases/use_case_deps.dart';
import 'package:flux_wallet/features/rules/domain/usecases/create_rule_from_transaction.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/add_transaction.dart';

/// Rules, exceptions and manual transactions.
mixin ScheduleUseCases on UseCaseDeps {
  late final loadSchedule = LoadScheduleContext(
    repos.dayFlags,
    repos.exceptions,
  );
  late final scheduleEditor = RuleScheduleEditor(
    repos.rules,
    repos.exceptions,
    repos.dayFlags,
  );
  late final addTransaction = AddTransaction(
    repos.transactions,
    CreateRuleFromTransaction(repos.rules, repos.exceptions),
    clock,
  );
}
