abstract interface class ReminderScheduler {
  /// False when the user refused notifications.
  Future<bool> requestPermission();

  /// Every day at [hour]:[minute] local time.
  Future<void> scheduleDaily(int hour, int minute, String title, String body);
  Future<void> cancel();
}
