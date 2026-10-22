import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The small "Büdcə" caption over the screen [title].
class TopBarTitle extends StatelessWidget {
  const TopBarTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
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
    );
  }
}
