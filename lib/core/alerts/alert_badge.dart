import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_kind.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The round, tinted icon at the start of an alert.
class AlertBadge extends StatelessWidget {
  const AlertBadge(this.kind, {super.key});

  final AlertKind kind;

  @override
  Widget build(BuildContext context) {
    final tint = kind.tint(context.colors);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: tint.withAlpha(36),
        shape: BoxShape.circle,
      ),
      child: Icon(kind.icon, color: tint, size: 20),
    );
  }
}
