import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/pages/rule_edit_page.dart';

/// The edit form of a rule. [from] is the day the change should start on
/// (the day the rule was opened from), else its next day.
Future<void> openRuleEdit(
  BuildContext context,
  RecurringRule rule, {
  DateTime? from,
}) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => RuleEditCubit(
          rule,
          deps.useCases.reviseRule,
          deps.clock,
          from: from,
        ),
        child: const RuleEditPage(),
      ),
    ),
  );
}
