import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';

/// Kart / Nağd.
class AccountSelector extends StatelessWidget {
  const AccountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) =>
          a.accounts != b.accounts || a.accountId != b.accountId,
      builder: (context, s) => FormRow(
        title: 'Hesab',
        subtitle: 'Ödəniş vasitəsi',
        trailing: s.accountId == null
            ? const SizedBox.shrink()
            : AdaptiveSegmented<int>(
                selected: s.accountId!,
                onChanged: context.read<NewTransactionCubit>().setAccount,
                options: {for (final a in s.accounts) a.id!: a.name},
              ),
      ),
    );
  }
}
