import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/new_transaction_page.dart';

/// Slides up from the bottom on iOS (fullscreen dialog), Material on Android.
/// A [date] later than today makes it a plan; [planned] starts on tomorrow.
Future<void> openNewTransaction(
  BuildContext context, {
  DateTime? date,
  bool planned = false,
}) {
  final deps = context.read<AppDependencies>();
  final tomorrow = deps.clock().add(const Duration(days: 1));
  return _open(context, date: date ?? (planned ? tomorrow : null));
}

/// The same form, filled with [transaction], to correct it.
Future<void> openEditTransaction(
  BuildContext context,
  Transaction transaction,
) => _open(context, editing: transaction);

Future<void> _open(
  BuildContext context, {
  DateTime? date,
  Transaction? editing,
}) {
  final deps = context.read<AppDependencies>();
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) => NewTransactionCubit(
          deps.useCases.addTransaction,
          deps.useCases.changeTransaction,
          deps.repos.accounts,
          deps.clock,
          date: date,
          editing: editing,
        )..init(),
        child: const NewTransactionPage(),
      ),
    ),
  );
}
