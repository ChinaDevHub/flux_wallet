import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_info.dart';
import 'package:flux_wallet/features/auth/presentation/cubit/login_cubit.dart';

/// Shown after a failed login: reveals the password hint of that username.
class HintButton extends StatelessWidget {
  const HintButton({super.key});

  Future<void> _show(BuildContext context) async {
    final hint = await context.read<LoginCubit>().hint();
    if (!context.mounted) return;
    await infoDialog(
      context,
      title: 'Şifrə xatırlatması',
      message: hint ?? 'Bu hesab üçün xatırlatma təyin edilməyib.',
    );
  }

  @override
  Widget build(BuildContext context) => Center(
    child: OutlinedButton.icon(
      onPressed: () => _show(context),
      icon: Icon(StatusIcons.tip),
      label: const Text('Şifrə xatırlatması'),
    ),
  );
}
