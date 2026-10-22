import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class PendingBannerText extends StatelessWidget {
  const PendingBannerText(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$count bank bildirişi təsdiq gözləyir',
          style: TextStyle(fontWeight: FontWeight.w800, color: c.text),
        ),
        Text(
          'Avtomatik kateqoriyalaşdırılıb',
          style: TextStyle(fontSize: 12, color: c.textMuted),
        ),
      ],
    );
  }
}
