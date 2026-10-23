import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/widgets/manage/row_action.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_row_actions.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/widgets/transaction_row_actions.dart';

/// What can be done to a line of [day]: a real transaction is edited or
/// removed, a planned one is edited or deleted like on the rules screen.
/// With [extended] a planned line may also end "from this day on".
List<RowAction> entryActions(
  BuildContext context,
  TimelineEntry entry,
  DateTime day,
  TimelineCubit cubit, {
  bool extended = false,
}) {
  final tx = entry.transaction;
  if (tx != null) return transactionRowActions(context, tx);
  final rule = entry.rule;
  if (rule == null) return const [];
  return [
    ...ruleRowActions(context, rule, onDelete: cubit.delete, from: day),
    if (extended && rule.id != null)
      RowAction(
        label: 'Bu gündən bitir',
        icon: StatusIcons.dayOff,
        destructive: true,
        onTap: () async {
          final ok = await confirmDialog(
            context,
            title: '${azDayMonth(day)} tarixindən bitsin?',
            message:
                '"${rule.title}" həmin gündən etibarən planlanmayacaq. '
                'Əvvəlki günlər olduğu kimi qalır.',
            confirmLabel: 'Bitir',
            destructive: true,
          );
          if (ok) await cubit.endFrom(rule, day);
        },
      ),
  ];
}
