import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/manage/swipe_actions.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_row_actions.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_actions.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_card.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/show_payment_sheet.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// A debt card wired to the cubit: pay (sheet), and edit / delete by swipe.
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SwipeActions(
        title: summary.debt.person,
        actions: debtRowActions(context, cubit, summary),
        child: DebtCard(
          summary: summary,
          today: today,
          actions: DebtActions(
            payLabel: lent ? 'Qaytarıldı' : 'Ödəniş et',
            onPay: open
                ? () => showPaymentSheet(context, cubit, summary, accounts)
                : null,
          ),
        ),
      ),
    );
  }
}
