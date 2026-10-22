import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// What an alert is about: it decides icon, tint, how long it stays and the
/// haptic tap that goes with it.
enum AlertKind {
  success(Duration(milliseconds: 2600)),
  info(Duration(milliseconds: 3200)),
  warning(Duration(milliseconds: 4200)),
  error(Duration(milliseconds: 4800));

  const AlertKind(this.duration);

  final Duration duration;

  IconData get icon => switch (this) {
    success => StatusIcons.success,
    info => StatusIcons.info,
    warning => StatusIcons.warning,
    error => StatusIcons.error,
  };

  Color tint(AppColors c) => switch (this) {
    success => c.positive,
    info => c.info,
    warning => c.accent,
    error => c.negative,
  };

  void haptic() => switch (this) {
    success => HapticFeedback.lightImpact(),
    error => HapticFeedback.mediumImpact(),
    _ => HapticFeedback.selectionClick(),
  };
}
