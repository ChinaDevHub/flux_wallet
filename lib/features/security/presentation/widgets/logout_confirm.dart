import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Çıxmaq istəyirsən? Bəli, çıx · Ləğv et" in one line.
class LogoutConfirm extends StatelessWidget {
  const LogoutConfirm({super.key, required this.onYes, required this.onNo});

  final VoidCallback onYes, onNo;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          'Çıxmaq istəyirsən?',
          style: TextStyle(fontSize: 13, color: c.textMuted),
        ),
        TextButton(
          onPressed: onYes,
          child: Text(
            'Bəli, çıx',
            style: TextStyle(color: c.negative, fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: onNo,
          child: Text('Ləğv et', style: TextStyle(color: c.text)),
        ),
      ],
    );
  }
}
