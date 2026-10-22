import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const eveningReminderDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'evening_reminder',
    'Axşam xatırlatması',
    importance: Importance.defaultImportance,
  ),
  iOS: DarwinNotificationDetails(),
);
