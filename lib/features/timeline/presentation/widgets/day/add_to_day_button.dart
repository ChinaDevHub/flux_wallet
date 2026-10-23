import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/action_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/transactions/presentation/pages/open_new_transaction.dart';

/// Opens the "+" form on this day: a record for a day that has come, a plan
/// for one that has not.
class AddToDayButton extends StatelessWidget {
  const AddToDayButton(this.day, {super.key});

  final TimelineDay day;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () => openNewTransaction(context, date: day.date),
        icon: Icon(ActionIcons.add, color: c.primary),
        label: Text(
          day.isFuture ? 'Bu günə plan əlavə et' : 'Əməliyyat əlavə et',
          style: TextStyle(color: c.primary, fontWeight: FontWeight.w700),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: c.primary.withValues(alpha: 0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
