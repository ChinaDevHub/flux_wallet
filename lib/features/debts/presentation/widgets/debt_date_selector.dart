import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

/// When the money changed hands: today, or earlier if it was forgotten.
class DebtDateSelector extends StatelessWidget {
  const DebtDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDebtCubit, NewDebtState>(
      buildWhen: (a, b) => a.date != b.date,
      builder: (context, s) => DayRow(
        title: 'Tarix',
        subtitle: 'Pul nə vaxt verildi / alındı',
        date: s.date,
        first: DateTime(s.date.year - 2),
        last: DateTime.now(),
        onPicked: context.read<NewDebtCubit>().setDate,
      ),
    );
  }
}
