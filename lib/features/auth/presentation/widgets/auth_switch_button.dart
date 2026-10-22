import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Hesabın yoxdur? Qeydiyyat" / "Artıq hesabın var? Giriş".
class AuthSwitchButton extends StatelessWidget {
  const AuthSwitchButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Center(
    child: TextButton(
      onPressed: onTap,
      child: Text(label, style: TextStyle(color: context.colors.primary)),
    ),
  );
}
