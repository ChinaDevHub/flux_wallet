import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Text('$title tezliklə', style: TextStyle(color: c.textMuted)),
    );
  }
}
