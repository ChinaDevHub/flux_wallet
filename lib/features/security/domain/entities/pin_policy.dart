/// What counts as a PIN, and how long a stranger has to wait between
/// guesses.
abstract final class PinPolicy {
  static const lengths = [4, 6];
  static const defaultLength = 4;

  /// Wrong PINs allowed before the pad starts making the user wait.
  static const maxAttempts = 5;

  /// The wait after the n-th lockout (1-based): each further wrong PIN waits
  /// longer, as the phone's own lock screen does.
  static const _waits = [
    Duration(seconds: 30),
    Duration(minutes: 1),
    Duration(minutes: 5),
    Duration(minutes: 15),
    Duration(hours: 1),
  ];

  static Duration waitAfter(int lockout) =>
      _waits[(lockout - 1).clamp(0, _waits.length - 1)];

  static final _digits = RegExp(r'^\d+$');

  static bool isValid(String pin) =>
      lengths.contains(pin.length) && _digits.hasMatch(pin);
}
