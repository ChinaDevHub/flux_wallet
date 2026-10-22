import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/pages/new_debt_page.dart';

/// Slides up from the bottom on iOS (fullscreen dialog), Material on Android.
Future<void> openNewDebt(BuildContext context) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => NewDebtCubit(
          deps.useCases.createDebt,
          deps.repos.accounts,
          deps.clock,
        )..init(),
        child: const NewDebtPage(),
      ),
    ),
  );
}
