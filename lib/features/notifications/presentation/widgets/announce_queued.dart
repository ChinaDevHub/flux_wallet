import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/notifications/presentation/pages/open_approval_page.dart';

/// A bank message just arrived while the app is open: say so, and offer to
/// jump to the approval queue.
void announceQueued(BuildContext context) {
  if (!context.mounted) return;
  context.alerts.info(
    'Təsdiq üçün yeni bank bildirişi gəldi',
    actionLabel: 'Bax',
    onAction: () {
      if (context.mounted) openApprovalPage(context);
    },
  );
}
