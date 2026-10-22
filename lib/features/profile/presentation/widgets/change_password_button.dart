import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/account_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/show_password_sheet.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colors.primary;
    return TextButton.icon(
      onPressed: () => showPasswordSheet(context),
      icon: Icon(AccountIcons.changePassword, color: color),
      label: Text('Şifrəni dəyiş', style: TextStyle(color: color)),
    );
  }
}
