import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// A bold label over a group of controls ("Kateqoriya", "Günlər", ...).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(fontWeight: FontWeight.w800, color: context.colors.text),
  );
}
