import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The fallback avatar: the first letters of the name on the brand colour.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.fullName,
    required this.radius,
  });

  final String fullName;
  final double radius;

  String get _initials {
    final words = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty);
    final letters = words.take(2).map((w) => w[0].toUpperCase()).join();
    return letters.isEmpty ? '?' : letters;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return CircleAvatar(
      radius: radius,
      backgroundColor: c.primary,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: radius * 0.8,
          fontWeight: FontWeight.w800,
          color: c.onPrimary,
        ),
      ),
    );
  }
}
