import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_badge.dart';
import 'package:flux_wallet/core/alerts/alert_text.dart';
import 'package:flux_wallet/core/alerts/app_alert.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The visual: icon badge, text and an optional action on a raised surface.
class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.alert, required this.onAction});

  final AppAlert alert;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final shape = BorderRadius.circular(20);
    return Material(
      color: c.surface,
      shadowColor: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: shape,
        side: BorderSide(color: c.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
        child: Row(
          spacing: 12,
          children: [
            AlertBadge(alert.kind),
            Expanded(child: AlertText(alert)),
            if (alert.hasAction)
              TextButton(
                onPressed: () {
                  onAction();
                  alert.onAction!();
                },
                child: Text(
                  alert.actionLabel!,
                  style: TextStyle(color: alert.kind.tint(c)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
