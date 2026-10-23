/// How long the app may stay in the background before it asks for the PIN
/// again. A per-device choice, like the theme.
enum LockTimeout {
  immediately(0, 'Dərhal'),
  oneMinute(60, '1 dəqiqə'),
  fiveMinutes(300, '5 dəqiqə');

  const LockTimeout(this.seconds, this.label);

  final int seconds;
  final String label;

  static const fallback = oneMinute;

  static LockTimeout fromSeconds(int? seconds) =>
      values.where((t) => t.seconds == seconds).firstOrNull ?? fallback;

  bool expired(DateTime hiddenAt, DateTime now) =>
      now.difference(hiddenAt).inSeconds >= seconds;
}
