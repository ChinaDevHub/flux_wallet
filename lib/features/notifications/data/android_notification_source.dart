import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';

/// Talks to the native `BankNotificationListener` over platform channels.
class AndroidNotificationSource implements NotificationSource {
  static const _events = EventChannel('flux_wallet/notification_events');
  static const _access = MethodChannel('flux_wallet/notification_access');

  @override
  bool get isSupported => true;

  @override
  Stream<RawNotification> get stream => _events.receiveBroadcastStream().map(
    (e) => _decode(jsonDecode(e as String)),
  );

  @override
  Future<List<RawNotification>> drain() async {
    final json = await _access.invokeMethod<String>('drain') ?? '[]';
    return [for (final e in jsonDecode(json) as List) _decode(e)];
  }

  @override
  Future<bool> isAccessGranted() async =>
      await _access.invokeMethod<bool>('isAccessGranted') ?? false;

  @override
  Future<void> openAccessSettings() =>
      _access.invokeMethod('openAccessSettings');

  RawNotification _decode(dynamic e) => RawNotification(
    text: e['text'] as String,
    source: e['source'] as String?,
    receivedAt: DateTime.fromMillisecondsSinceEpoch(e['postedAt'] as int),
  );
}
