import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget item(IconData icon, String label, {bool active = false}) {
      final color = active ? c.positive : c.textMuted;
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      );
    }

    return BottomAppBar(
      color: c.surface,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        children: [
          item(Icons.home_rounded, 'Əsas', active: true),
          item(Icons.history_rounded, 'Timeline'),
          const Spacer(),
          item(Icons.account_balance_wallet_outlined, 'Borclar'),
          item(Icons.bar_chart_rounded, 'Statistika'),
        ],
      ),
    );
  }
}
