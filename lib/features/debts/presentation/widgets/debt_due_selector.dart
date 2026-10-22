import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

/// When it must be paid back; required only for a debt I took.
class DebtDueSelector extends StatelessWidget {
  const DebtDueSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDebtCubit, NewDebtState>(
      buildWhen: (a, b) =>
          a.dueDate != b.dueDate ||
          a.direction != b.direction ||
          a.date != b.date,
      builder: (context, s) => DayRow(
        title: 'Son tarix',
        subtitle: s.needsDueDate
            ? 'Məcburi xərc kimi bu tarixə bağlanır'
            : 'İstəyə bağlı',
        date: s.dueDate,
        first: s.date,
        last: DateTime(s.date.year + 5),
        onPicked: context.read<NewDebtCubit>().setDue,
      ),
    );
  }
}
