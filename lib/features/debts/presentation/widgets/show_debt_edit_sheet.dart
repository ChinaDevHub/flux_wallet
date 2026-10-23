import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/widgets/debt_edit_sheet.dart';

void showDebtEditSheet(
  BuildContext context,
  DebtsCubit cubit,
  DebtSummary summary,
) {
  final alerts = context.alerts;
  showAppSheet<void>(
    context,
    (_) => DebtEditSheet(
      summary: summary,
      onSave: (person, due, note) async {
        try {
          await cubit.edit(summary, (person: person, dueDate: due, note: note));
          alerts.success('Borc yeniləndi');
        } catch (_) {
          alerts.error('Yadda saxlamaq alınmadı. Yenidən cəhd et');
        }
      },
    ),
  );
}
