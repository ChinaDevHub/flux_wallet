import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/widgets/resume_listener.dart';
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
    this.onQueued,
  });

  final NotificationSource source;
  final IngestNotification ingest;
  final Widget child;
  final VoidCallback? onQueued;

  @override
  State<NotificationIngestHost> createState() => _NotificationIngestHostState();
}

class _NotificationIngestHostState extends State<NotificationIngestHost> {
  late final _feed = NotificationFeed(
    widget.source,
    widget.ingest,
    onQueued: widget.onQueued,
  );

  @override
  void initState() {
    super.initState();
    _feed.start();
  }

  @override
  void dispose() {
    _feed.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ResumeListener(onResume: _feed.drain, child: widget.child);
}
