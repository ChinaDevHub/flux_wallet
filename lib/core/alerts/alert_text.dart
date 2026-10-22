import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/app_alert.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Optional bold title over the message.
class AlertText extends StatelessWidget {
  const AlertText(this.alert, {super.key});

  final AppAlert alert;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final hasTitle = alert.title != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasTitle)
          Text(
            alert.title!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: c.text,
            ),
          ),
        Text(
          alert.message,
          style: TextStyle(
            fontSize: hasTitle ? 13.5 : 15,
            height: 1.3,
            fontWeight: hasTitle ? FontWeight.w500 : FontWeight.w700,
            color: hasTitle ? c.textMuted : c.text,
          ),
        ),
      ],
    );
  }
}
