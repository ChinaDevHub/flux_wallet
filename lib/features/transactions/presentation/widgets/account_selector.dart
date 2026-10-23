import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/account_row.dart';

/// Kart / Nağd.
class AccountSelector extends StatelessWidget {
  const AccountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) =>
          a.accounts != b.accounts ||
          a.accountId != b.accountId ||
          a.isPlan != b.isPlan,
      // A plan has no account yet: the money moves when the day comes.
      builder: (context, s) => s.isPlan
          ? const SizedBox.shrink()
          : AccountRow(
              accounts: s.accounts,
              selectedId: s.accountId,
              onChanged: context.read<NewTransactionCubit>().setAccount,
            ),
    );
  }
}
