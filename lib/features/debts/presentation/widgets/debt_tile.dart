import 'package:flutter/material.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/confirm_delete_debt.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_actions.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_card.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/show_payment_sheet.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// A debt card wired to the cubit: pay (sheet) and delete (confirmation).
class DebtTile extends StatelessWidget {
  const DebtTile({
    super.key,
    required this.summary,
    required this.accounts,
    required this.cubit,
    required this.today,
  });

  final DebtSummary summary;
  final List<Account> accounts;
  final DebtsCubit cubit;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final open = !summary.debt.isClosed;
    final lent = summary.debt.direction == DebtDirection.lent;
    return DebtCard(
      summary: summary,
      today: today,
      actions: DebtActions(
        payLabel: lent ? 'Qaytarıldı' : 'Ödəniş et',
        onPay: open
            ? () => showPaymentSheet(context, cubit, summary, accounts)
            : null,
        onDelete: () async {
          if (await confirmDeleteDebt(context, summary)) cubit.delete(summary);
        },
      ),
    );
  }
}
