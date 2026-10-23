import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat/repeat_options.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/repeat_chips.dart';

/// "Təkrarla": the frequency chips and, once one is picked, its details
/// (days, end, paused months) with a plain-language summary.
class RepeatSection extends StatelessWidget {
  const RepeatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.repeat != b.repeat || a.date != b.date,
      builder: (context, s) => AnimatedSize(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RepeatChips(),
            if (s.repeat != null) ...[
              const SizedBox(height: 12),
              RepeatOptions(plan: s.repeat!, start: s.date),
            ],
          ],
        ),
      ),
    );
  }
}
