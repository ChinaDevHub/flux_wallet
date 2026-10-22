import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_card.dart';
import 'package:flux_wallet/core/alerts/app_alert.dart';

/// Runs the auto-dismiss timer; a tap or an upward swipe closes it early.
class AlertBanner extends StatefulWidget {
  const AlertBanner({super.key, required this.alert, required this.onDismiss});

  final AppAlert alert;
  final VoidCallback onDismiss;

  @override
  State<AlertBanner> createState() => _AlertBannerState();
}

class _AlertBannerState extends State<AlertBanner> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.alert.duration, widget.onDismiss);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: GestureDetector(
        onTap: widget.onDismiss,
        onVerticalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) < -120) widget.onDismiss();
        },
        child: AlertCard(alert: widget.alert, onAction: widget.onDismiss),
      ),
    );
  }
}
