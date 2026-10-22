import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// Past dates only: the future is planned by rules, not by transactions.
class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.date != b.date,
      builder: (context, s) => DayRow(
        title: 'Tarix',
        subtitle: 'Əməliyyat vaxtı',
        date: s.date,
        first: DateTime(s.date.year - 2),
        last: DateTime.now(),
        onPicked: context.read<NewTransactionCubit>().setDate,
      ),
    );
  }
}
