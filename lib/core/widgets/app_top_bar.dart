import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Büdcə / <title>" bar with the logo on the left and avatar on the right.
class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget avatar(IconData icon) => CircleAvatar(
      radius: 18,
      backgroundColor: c.primary,
      child: Icon(icon, size: 19, color: c.onPrimary),
    );
    return Row(
      children: [
        avatar(Icons.account_balance_wallet_rounded),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Büdcə', style: TextStyle(fontSize: 11, color: c.textMuted)),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: c.text,
                ),
              ),
            ],
          ),
        ),
        ...actions,
        Icon(Icons.notifications_none_rounded, color: c.text),
        const SizedBox(width: 14),
        avatar(Icons.person_outline_rounded),
      ],
    );
  }
}
