import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';

/// "Hesabdan çıx", behind a clear warning.
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.cubit});

  final ProfileCubit cubit;

  Future<void> _logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    final ok = await confirmDialog(
      context,
      title: 'Hesabdan çıx',
      message:
          'Çıxdıqdan sonra bu cihazda yenidən daxil olmaq üçün istifadəçi adı '
          'və şifrə lazım olacaq. Məlumatların silinməyəcək.',
      confirmLabel: 'Çıx',
      destructive: true,
    );
    if (!ok) return;
    await cubit.logout();
    navigator.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () => _logout(context),
        icon: Icon(Icons.logout_rounded, color: c.negative),
        label: Text(
          'Hesabdan çıx',
          style: TextStyle(color: c.negative, fontWeight: FontWeight.w700),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: c.negative.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
