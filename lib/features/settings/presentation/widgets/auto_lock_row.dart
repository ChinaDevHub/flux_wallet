import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/security_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/security/domain/entities/lock_timeout.dart';
import 'package:flux_wallet/features/settings/presentation/widgets/settings_row.dart';

/// "Avtomatik kilid": Dərhal / 1 dəqiqə / 5 dəqiqə in the background.
class AutoLockRow extends StatelessWidget {
  const AutoLockRow({
    super.key,
    required this.timeout,
    required this.onChanged,
  });

  final LockTimeout timeout;
  final ValueChanged<LockTimeout> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsRow(
          icon: SecurityIcons.timer,
          title: 'Avtomatik kilid',
          subtitle: 'Arxa fonda bu qədər qalandan sonra PIN istənir',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            width: double.infinity,
            child: AdaptiveSegmented<LockTimeout>(
              selected: timeout,
              onChanged: onChanged,
              options: {for (final t in LockTimeout.values) t: t.label},
            ),
          ),
        ),
      ],
    );
  }
}
