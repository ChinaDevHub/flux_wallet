import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rules_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/pages/rules_page.dart';

Future<void> openRulesPage(BuildContext context) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => RulesCubit(
          deps.repos.rules,
          deps.useCases.scheduleEditor,
          deps.changes,
        )..load(),
        child: const RulesPage(),
      ),
    ),
  );
}
