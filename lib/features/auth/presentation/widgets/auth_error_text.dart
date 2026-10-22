import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class AuthErrorText extends StatelessWidget {
  const AuthErrorText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: context.colors.negative,
      fontWeight: FontWeight.w600,
    ),
  );
}
