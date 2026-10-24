import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/security/presentation/widgets/logout_confirm.dart';

/// "Hesabdan çıx" with an inline yes/no: the way out when the PIN is
/// forgotten (the password gets the account back).
class LockFooter extends StatefulWidget {
  const LockFooter({super.key});

  @override
  State<LockFooter> createState() => _LockFooterState();
}

class _LockFooterState extends State<LockFooter> {
  bool _confirm = false;

  /// Coming back needs the password, so the wrong-PIN count starts over.
  Future<void> _logout() async {
    final u = context.read<AppDependencies>().useCases;
    await u.pinGuard.reset();
    await u.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_confirm) {
      return LogoutConfirm(
        onYes: _logout,
        onNo: () => setState(() => _confirm = false),
      );
    }
    return TextButton(
      onPressed: () => setState(() => _confirm = true),
      child: Text(
        'Hesabdan çıx',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}
