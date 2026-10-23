import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/platform/adaptive_confirm.dart';

/// Asks first (it cannot be undone), then wipes the user's money data. The
/// app then goes to first-time setup by itself.
Future<void> runResetData(BuildContext context) async {
  final reset = context.read<AppDependencies>().useCases.resetData;
  final alerts = context.alerts;
  final ok = await confirmDialog(
    context,
    title: 'Hər şey sıfırlansın?',
    message:
        'Bütün hesablar, əməliyyatlar, qaydalar, borclar və bank '
        'bildirişləri silinəcək. Bunu geri qaytarmaq olmur. Hesabın, şifrən '
        'və PIN-in qalır. Əvvəlcə ehtiyat nüsxə yaratmağı məsləhət görürük.',
    confirmLabel: 'Hamısını sil',
    destructive: true,
  );
  if (!ok) return;
  try {
    await reset();
    alerts.success('Bütün məlumatlar sıfırlandı');
  } catch (_) {
    alerts.error('Sıfırlamaq alınmadı. Yenidən cəhd et.');
  }
}
