import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Asks for notification permission the way the current platform wants it.
Future<bool> askNotificationPermission(
  FlutterLocalNotificationsPlugin plugin,
) async {
  final android = plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  if (android != null) {
    return await android.requestNotificationsPermission() ?? false;
  }
  final ios = plugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();
  final granted = await ios?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
  return granted ?? false;
}
