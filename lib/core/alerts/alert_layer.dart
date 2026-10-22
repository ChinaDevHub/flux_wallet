import 'package:flutter/material.dart';
import 'package:flux_wallet/core/alerts/alert_banner.dart';
import 'package:flux_wallet/core/alerts/alert_controller.dart';
import 'package:flux_wallet/core/alerts/alert_transition.dart';

/// Shows the current alert under the status bar, centred and width-capped
/// so it also looks right on a tablet.
class AlertLayer extends StatelessWidget {
  const AlertLayer({super.key, required this.controller});

  final AlertController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final alert = controller.current;
        return SafeArea(
          bottom: false,
          minimum: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 360),
                reverseDuration: const Duration(milliseconds: 220),
                transitionBuilder: alertTransition,
                child: alert == null
                    ? const SizedBox(width: double.infinity)
                    : AlertBanner(
                        key: ValueKey(controller.serial),
                        alert: alert,
                        onDismiss: () => controller.dismiss(controller.serial),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
