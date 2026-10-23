import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule_live.dart';

/// Says plainly what deleting does: the days to come go, the days gone stay.
Future<bool> confirmDeleteRule(BuildContext context, RecurringRule rule) {
  final kept = rule.hasHistory(dateOnly(DateTime.now()));
  return confirmDialog(
    context,
    title: '"${rule.title}" silinsin?',
    message: kept
        ? 'Bu gündən etibarən planlanmayacaq və gündəlik limitin yenidən '
              'hesablanacaq. Keçmiş günlər və onların limiti dəyişməyəcək.'
        : 'Bu plan silinəcək.',
    confirmLabel: 'Sil',
    destructive: true,
  );
}
