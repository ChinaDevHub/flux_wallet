import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/new_transaction_page.dart';

/// Slides up from the bottom on iOS (fullscreen dialog), Material on Android.
Future<void> openNewTransaction(BuildContext context) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => NewTransactionCubit(
          deps.useCases.addTransaction,
          deps.repos.accounts,
          deps.clock,
        )..init(),
        child: const NewTransactionPage(),
      ),
    ),
  );
}
