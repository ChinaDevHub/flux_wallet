import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// "Təkrarla": turns the transaction into a recurring rule.
class RepeatChips extends StatelessWidget {
  const RepeatChips({super.key});

  static const _options = <Frequency?, String>{
    null: 'Yox',
    Frequency.daily: 'Hər gün',
    Frequency.weekdays: 'İş günləri',
    Frequency.weekly: 'Həftəlik',
    Frequency.monthly: 'Aylıq',
  };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.repeat != b.repeat,
      builder: (context, s) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Təkrarla',
            style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final e in _options.entries)
                ChoiceChip(
                  label: Text(e.value),
                  selected: s.repeat == e.key,
                  showCheckmark: false,
                  onSelected: (_) =>
                      context.read<NewTransactionCubit>().setRepeat(e.key),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
