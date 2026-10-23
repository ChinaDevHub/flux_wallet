import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/frequency_chips.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/repeat_options.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// "Təkrarla": the frequency chips and, once one is picked, its details
/// (days, end, paused months) with a plain-language summary.
class RepeatSection extends StatelessWidget {
  const RepeatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewTransactionCubit>();
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.repeat != b.repeat || a.date != b.date,
      // Correcting a recorded transaction cannot also start a repetition.
      builder: (context, s) => s.isEditing
          ? const SizedBox.shrink()
          : AnimatedSize(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrequencyChips(
                    selected: s.repeat?.frequency,
                    onChanged: cubit.setRepeat,
                  ),
                  if (s.repeat != null) ...[
                    const SizedBox(height: 12),
                    RepeatOptions(
                      plan: s.repeat!,
                      start: s.date,
                      onChanged: cubit.updateRepeat,
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
