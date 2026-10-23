import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Hesabdan çıx" with an inline yes/no: the way out when the PIN is
/// forgotten (the password gets the account back).
class LockFooter extends StatefulWidget {
  const LockFooter({super.key});

  @override
  State<LockFooter> createState() => _LockFooterState();
}

class _LockFooterState extends State<LockFooter> {
  bool _confirm = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final muted = TextStyle(fontSize: 13, color: c.textMuted);
    if (!_confirm) {
      return TextButton(
        onPressed: () => setState(() => _confirm = true),
        child: Text(
          'Hesabdan çıx',
          style: muted.copyWith(fontWeight: FontWeight.w600),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        Text('Çıxmaq istəyirsən?', style: muted),
        TextButton(
          onPressed: context.read<AppDependencies>().useCases.logoutUser.call,
          child: Text(
            'Bəli, çıx',
            style: TextStyle(color: c.negative, fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _confirm = false),
          child: Text('Ləğv et', style: TextStyle(color: c.text)),
        ),
      ],
    );
  }
}
