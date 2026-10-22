import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/account_row.dart';

/// Which account the money went into (borrowed) or came out of (lent).
class DebtAccountSelector extends StatelessWidget {
  const DebtAccountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewDebtCubit, NewDebtState>(
      buildWhen: (a, b) =>
          a.accounts != b.accounts ||
          a.accountId != b.accountId ||
          a.needsDueDate != b.needsDueDate,
      builder: (context, s) => AccountRow(
        accounts: s.accounts,
        selectedId: s.accountId,
        onChanged: context.read<NewDebtCubit>().setAccount,
        subtitle: s.needsDueDate
            ? 'Pul hansı hesaba daxil oldu'
            : 'Pul hansı hesabdan çıxdı',
      ),
    );
  }
}
