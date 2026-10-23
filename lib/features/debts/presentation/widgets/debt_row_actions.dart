import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/confirm_delete_debt.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/show_debt_edit_sheet.dart';

/// Redaktə et and Sil for a debt: the same two actions as everywhere.
List<RowAction> debtRowActions(
  BuildContext context,
  DebtsCubit cubit,
  DebtSummary summary,
) => [
  RowAction(
    label: 'Redaktə et',
    icon: ActionIcons.edit,
    onTap: () => showDebtEditSheet(context, cubit, summary),
  ),
  RowAction(
    label: 'Sil',
    icon: ActionIcons.delete,
    destructive: true,
    onTap: () async {
      if (await confirmDeleteDebt(context, summary)) cubit.delete(summary);
    },
  ),
];
