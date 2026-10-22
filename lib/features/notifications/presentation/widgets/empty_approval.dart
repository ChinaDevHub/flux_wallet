import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class EmptyApproval extends StatelessWidget {
  const EmptyApproval({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Column(
        spacing: 10,
        children: [
          Icon(Icons.inbox_outlined, size: 48, color: c.textMuted),
          Text(
            'Təsdiq gözləyən bildiriş yoxdur',
            style: TextStyle(color: c.text),
          ),
          Text(
            'Bank mətnini əl ilə əlavə etmək üçün yuxarıdakı ✎ düyməsinə bas.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: c.textMuted),
          ),
        ],
      ),
    );
  }
}
