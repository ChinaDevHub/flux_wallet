import 'package:flutter/foundation.dart';
import 'package:flux_wallet/core/alerts/alert_kind.dart';
import 'package:flux_wallet/core/alerts/app_alert.dart';

/// Holds the alert being shown. A new one replaces the old one, like the
/// system banners do; [serial] tells the UI it is a different message.
class AlertController extends ChangeNotifier {
  AppAlert? current;
  int serial = 0;

  void show(AppAlert alert) {
    alert.kind.haptic();
    current = alert;
    serial++;
    notifyListeners();
  }

  /// Only the alert that asked for it may dismiss itself (a timer that fires
  /// late must not close its successor).
  void dismiss([int? onlySerial]) {
    if (current == null || (onlySerial != null && onlySerial != serial)) return;
    current = null;
    notifyListeners();
  }

  void success(String message, {String? title}) =>
      show(AppAlert(kind: AlertKind.success, message: message, title: title));

  void error(String message, {String? title}) =>
      show(AppAlert(kind: AlertKind.error, message: message, title: title));

  void warning(String message, {String? title}) =>
      show(AppAlert(kind: AlertKind.warning, message: message, title: title));

  void info(
    String message, {
    String? title,
    String? actionLabel,
    VoidCallback? onAction,
  }) => show(
    AppAlert(
      kind: AlertKind.info,
      message: message,
      title: title,
      actionLabel: actionLabel,
      onAction: onAction,
    ),
  );
}
