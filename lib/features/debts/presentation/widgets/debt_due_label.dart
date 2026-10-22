import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

class DebtDueLabel extends StatelessWidget {
  const DebtDueLabel(this.summary, this.today, {super.key});

  final DebtSummary summary;
  final DateTime today;

  String get _text {
    final due = summary.debt.dueDate;
    if (summary.debt.isClosed) return 'Tam qaytarılıb';
    if (due == null) return 'Tarix təyin edilməyib';
    if (summary.isOverdue(today)) return '${azDayMonth(due)} · gecikib';
    final days = summary.daysLeft(today);
    return '${azDayMonth(due)} · ${days == 0 ? 'bu gün' : '$days gün qalıb'}';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Text(
      _text,
      style: TextStyle(
        fontSize: 12,
        color: summary.isOverdue(today) ? c.negative : c.textMuted,
      ),
    );
  }
}
