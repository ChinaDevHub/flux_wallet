import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/alerts/alert_controller.dart';
import 'package:flux_wallet/core/alerts/alert_layer.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';

/// Wraps the whole app (above the Navigator) so alerts float over every
/// screen, sheet and dialog.
class AlertHost extends StatefulWidget {
  const AlertHost({super.key, required this.child});

  final Widget child;

  @override
  State<AlertHost> createState() => _AlertHostState();
}

class _AlertHostState extends State<AlertHost> {
  final _controller = AlertController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertScope(
      controller: _controller,
      child: Stack(
        children: [
          widget.child,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AlertLayer(controller: _controller),
          ),
        ],
      ),
    );
  }
}
