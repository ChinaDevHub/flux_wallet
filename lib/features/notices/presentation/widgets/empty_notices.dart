import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Nothing needs attention: a calm all-clear.
class EmptyNotices extends StatelessWidget {
  const EmptyNotices({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Icon(StatusIcons.success, size: 56, color: c.positive),
          Text(
            'Hər şey qaydasındadır',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: c.text,
            ),
          ),
          Text(
            'Diqqət tələb edən bildiriş yoxdur',
            style: TextStyle(color: c.textMuted),
          ),
        ],
      ),
    );
  }
}
