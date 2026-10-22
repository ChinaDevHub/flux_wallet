import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// Xərc / Gəlir.
class KindSelector extends StatelessWidget {
  const KindSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.kind != b.kind,
      builder: (context, s) => SizedBox(
        width: double.infinity,
        child: AdaptiveSegmented<TransactionKind>(
          selected: s.kind,
          onChanged: context.read<NewTransactionCubit>().setKind,
          options: {for (final k in TransactionKind.values) k: k.label},
        ),
      ),
    );
  }
}
