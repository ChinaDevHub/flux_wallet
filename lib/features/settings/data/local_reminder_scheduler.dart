import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flux_wallet/features/settings/data/next_occurrence.dart';
import 'package:flux_wallet/features/settings/data/reminder_details.dart';
import 'package:flux_wallet/features/settings/data/reminder_plugin.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';

class LocalReminderScheduler implements ReminderScheduler {
  LocalReminderScheduler([ReminderPlugin? plugin])
    : _plugin = plugin ?? ReminderPlugin();

  static const _id = 2100;
  final ReminderPlugin _plugin;

  @override
  Future<bool> requestPermission() => _plugin.askPermission();

  @override
  Future<void> scheduleDaily(
    int hour,
    int minute,
    String title,
    String body,
  ) async {
    await _plugin.ensureReady();
    await _plugin.plugin.zonedSchedule(
      id: _id,
      title: title,
      body: body,
      scheduledDate: nextOccurrence(hour, minute),
      notificationDetails: eveningReminderDetails,
      // Inexact: no special "exact alarm" permission is needed for a nudge.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancel() async {
    await _plugin.ensureReady();
    await _plugin.plugin.cancel(id: _id);
  }
}
