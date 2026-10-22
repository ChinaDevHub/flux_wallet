import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';

/// Where raw notifications come from (Android listener, or nothing on iOS).
abstract interface class NotificationSource {
  bool get isSupported;

  /// Live notifications while the app process is running.
  Stream<RawNotification> get stream;

  /// Notifications captured while the app was not listening.
  Future<List<RawNotification>> drain();
  Future<bool> isAccessGranted();
  Future<void> openAccessSettings();
}
