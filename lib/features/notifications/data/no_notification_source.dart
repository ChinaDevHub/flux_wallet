import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';

/// iOS gives apps no access to other apps' notifications; messages are pasted
/// in by hand there (see the approval screen).
class NoNotificationSource implements NotificationSource {
  const NoNotificationSource();

  @override
  bool get isSupported => false;

  @override
  Stream<RawNotification> get stream => const Stream.empty();

  @override
  Future<List<RawNotification>> drain() async => const [];

  @override
  Future<bool> isAccessGranted() async => false;

  @override
  Future<void> openAccessSettings() async {}
}
