/// What counts as a PIN, and how many tries a stranger gets.
abstract final class PinPolicy {
  static const lengths = [4, 6];
  static const defaultLength = 4;
  static const maxAttempts = 5;
  static const cooldown = Duration(seconds: 30);

  static final _digits = RegExp(r'^\d+$');

  static bool isValid(String pin) =>
      lengths.contains(pin.length) && _digits.hasMatch(pin);
}
