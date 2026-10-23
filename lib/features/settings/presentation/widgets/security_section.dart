import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/icons/security_icons.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/cubit/security_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/security_state.dart';
import 'package:flux_wallet/features/security/presentation/pages/open_pin_setup.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/auto_lock_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/pin_toggle_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_section.dart';

/// The PIN lock: on/off, change, and how soon the app re-locks.
class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SecurityCubit>();
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, s) => SettingsSection(
        title: 'Təhlükəsizlik',
        footer:
            'PIN yalnız bu hesab üçündür və cihazda şifrələnmiş saxlanılır. '
            'Unutsan, hesabdan çıxıb şifrənlə yenidən daxil ola bilərsən.',
        children: [
          PinToggleRow(s),
          if (s.pinEnabled) ...[
            SettingsRow(
              icon: SecurityIcons.changePin,
              title: 'PIN-i dəyiş',
              subtitle: 'Əvvəlcə indiki kod soruşulur',
              trailing: Icon(ArrowIcons.next),
              onTap: () => openPinSetup(context, PinFlowMode.change),
            ),
            AutoLockRow(timeout: s.timeout, onChanged: cubit.setTimeout),
          ],
        ],
      ),
    );
  }
}
