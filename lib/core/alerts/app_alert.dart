import 'package:flutter/foundation.dart';
import 'package:flux_wallet/core/alerts/alert_kind.dart';

/// One message for the user. An [actionLabel] with [onAction] adds a button
/// (e.g. "Bax") and keeps the alert on screen a little longer.
@immutable
class AppAlert {
  const AppAlert({
    required this.kind,
    required this.message,
    this.title,
    this.actionLabel,
    this.onAction,
  });

  final AlertKind kind;
  final String message;
  final String? title, actionLabel;
  final VoidCallback? onAction;

  bool get hasAction => actionLabel != null && onAction != null;

  Duration get duration =>
      hasAction ? kind.duration + const Duration(seconds: 3) : kind.duration;
}
