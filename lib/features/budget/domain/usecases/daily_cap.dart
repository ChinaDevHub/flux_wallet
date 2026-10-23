import 'package:flux_wallet/features/settings/domain/scoped_settings.dart';
import 'package:flux_wallet/features/budget/domain/entities/budget_keys.dart';

/// The most the user wants to spend in one day, chosen in Ayarlar. The app's
/// own daily limit can only be lowered by it, never raised. Unset by default.
class DailyCap {
  const DailyCap(this._settings);

  final ScopedSettings _settings;

  /// Null when the user has not set one (or nobody is signed in).
  Future<double?> read() async {
    try {
      return double.tryParse(await _settings.read(BudgetKeys.dailyCap) ?? '');
    } on StateError {
      return null;
    }
  }

  Future<void> write(double amount) {
    if (amount <= 0) throw ArgumentError.value(amount, 'amount');
    return _settings.write(BudgetKeys.dailyCap, '$amount');
  }

  Future<void> clear() => _settings.clear(BudgetKeys.dailyCap);

  /// The limit the user lives by: the app's [computed] amount, lowered to
  /// the personal cap when there is one.
  static double effective(double computed, double? cap) =>
      cap == null || cap > computed ? computed : cap;
}
