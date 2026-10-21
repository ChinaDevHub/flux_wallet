import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';

class QuickAmountChips extends StatelessWidget {
  const QuickAmountChips({super.key});

  static const _steps = [1.0, 5.0, 10.0, 50.0];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<NewTransactionCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        for (final step in _steps)
          ActionChip(
            label: Text('+${formatPlain(step)} $azn'),
            backgroundColor: c.surfaceAlt,
            side: BorderSide.none,
            shape: const StadiumBorder(),
            onPressed: () => cubit.addAmount(step),
          ),
      ],
    );
  }
}
