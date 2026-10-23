import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/security_icons.dart';
import 'package:flux_wallet/core/platform/app_switch.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/cubit/security_state.dart';
import 'package:flux_wallet/features/security/presentation/pages/open_pin_setup.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';

/// The switch opens the set-up (on) or the remove flow (off); if that flow
/// is cancelled the switch simply stays where it was.
class PinToggleRow extends StatelessWidget {
  const PinToggleRow(this.state, {super.key});

  final SecurityState state;

  @override
  Widget build(BuildContext context) {
    final s = state;
    return SettingsRow(
      icon: SecurityIcons.lock,
      title: 'PIN kodu',
      subtitle: s.pinEnabled
          ? 'Aktivdir · ${s.pinLength} rəqəm'
          : 'Tətbiqi kənar gözlərdən qoru',
      trailing: AppSwitch(
        value: s.pinEnabled,
        onChanged: (on) =>
            openPinSetup(context, on ? PinFlowMode.create : PinFlowMode.remove),
      ),
    );
  }
}
