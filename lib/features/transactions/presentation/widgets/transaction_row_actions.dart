import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/transactions/domain/usecases/change_transaction.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/open_new_transaction.dart';

/// Redaktə et and Sil for a recorded transaction, wherever it is listed.
/// Money that belongs to a debt is managed on the Borclar tab: no actions.
List<RowAction> transactionRowActions(BuildContext context, Transaction tx) {
  if (!ChangeTransaction.canChange(tx)) return const [];
  final changes = context.read<AppDependencies>().useCases.changeTransaction;
  return [
    RowAction(
      label: 'Redaktə et',
      icon: ActionIcons.edit,
      onTap: () => openEditTransaction(context, tx),
    ),
    RowAction(
      label: 'Sil',
      icon: ActionIcons.delete,
      destructive: true,
      onTap: () async {
        final ok = await confirmDialog(
          context,
          title: 'Əməliyyat silinsin?',
          message: 'Məbləğ hesabın balansına geri qaytarılacaq.',
          confirmLabel: 'Sil',
          destructive: true,
        );
        if (ok) await changes.remove(tx);
      },
    ),
  ];
}
