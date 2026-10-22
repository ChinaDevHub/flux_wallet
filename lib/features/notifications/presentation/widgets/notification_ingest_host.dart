import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/ingest_notification.dart';
import 'package:flux_wallet/features/notifications/presentation/widgets/notification_feed.dart';

/// Feeds live notifications — and the ones captured while the app was closed —
/// into the pending queue for as long as the app is open.
class NotificationIngestHost extends StatefulWidget {
  const NotificationIngestHost({
    super.key,
    required this.source,
    required this.ingest,
    required this.child,
  });

  final NotificationSource source;
  final IngestNotification ingest;
  final Widget child;

  @override
  State<NotificationIngestHost> createState() => _NotificationIngestHostState();
}

class _NotificationIngestHostState extends State<NotificationIngestHost>
    with WidgetsBindingObserver {
  late final _feed = NotificationFeed(widget.source, widget.ingest);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _feed.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _feed.drain();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _feed.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
