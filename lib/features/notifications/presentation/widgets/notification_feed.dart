import 'dart:async';

import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/ingest_notification.dart';

/// Pipes a [NotificationSource] into the pending queue.
class NotificationFeed {
  NotificationFeed(this._source, this._ingest);

  final NotificationSource _source;
  final IngestNotification _ingest;
  StreamSubscription<RawNotification>? _subscription;

  void start() {
    _subscription = _source.stream.listen(_handle);
    drain();
  }

  /// Notifications captured while the app was not listening.
  Future<void> drain() async {
    for (final raw in await _source.drain()) {
      await _handle(raw);
    }
  }

  Future<void> _handle(RawNotification raw) async {
    try {
      await _ingest(raw);
    } catch (_) {
      // A broken message must never take the listener down.
    }
  }

  void stop() => _subscription?.cancel();
}
