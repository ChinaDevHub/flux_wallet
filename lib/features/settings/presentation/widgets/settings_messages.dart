import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/settings/presentation/cubit/settings_result.dart';

/// Tells the user how a settings action went. [done] is the success text for
/// actions with no visible result of their own (e.g. a restore).
void showSettingsResult(
  BuildContext context,
  SettingsResult result, {
  String done = 'Hazırdır',
}) {
  final alerts = context.alerts;
  switch (result) {
    case SettingsResult.done:
      alerts.success(done);
    case SettingsResult.denied:
      alerts.warning(
        'Bildiriş icazəsini sistem ayarlarından aç.',
        title: 'İcazə verilmədi',
      );
    case SettingsResult.invalid:
      alerts.error('Bu fayl Flux Wallet ehtiyat nüsxəsi deyil.');
    case SettingsResult.failed:
      alerts.error('Əməliyyat alınmadı. Yenidən cəhd et.');
    case SettingsResult.cancelled:
      break;
  }
}
