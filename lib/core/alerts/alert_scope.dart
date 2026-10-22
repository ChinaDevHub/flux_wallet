import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/alerts/alert_controller.dart';

/// Makes the [AlertController] reachable as `context.alerts`.
class AlertScope extends InheritedWidget {
  const AlertScope({super.key, required this.controller, required super.child});

  final AlertController controller;

  @override
  bool updateShouldNotify(AlertScope old) => controller != old.controller;
}

final _detached = AlertController();

extension AlertsX on BuildContext {
  /// Without an [AlertHost] above (e.g. in isolated widget tests) alerts go
  /// nowhere instead of crashing.
  AlertController get alerts =>
      dependOnInheritedWidgetOfExactType<AlertScope>()?.controller ?? _detached;
}
