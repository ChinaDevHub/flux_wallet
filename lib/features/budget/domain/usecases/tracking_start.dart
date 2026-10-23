import 'package:flux_wallet/features/settings/domain/scoped_settings.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/auth/domain/repositories/user_repository.dart';
import 'package:flux_wallet/features/budget/domain/entities/budget_keys.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// The first day the app has data about: where the calendar starts. It is
/// the day the user began (or last reset), or the oldest back-dated
/// transaction when that is earlier.
class TrackingStart {
  const TrackingStart(this._settings, this._users, this._transactions);

  final ScopedSettings _settings;
  final UserRepository _users;
  final TransactionRepository _transactions;

  Future<DateTime> call(DateTime today) async {
    final saved = DateTime.tryParse(
      await _settings.read(BudgetKeys.trackingSince) ?? '',
    );
    final joined = (await _users.current())?.createdAt;
    final since = dateOnly(saved ?? joined ?? today);
    final first = await _transactions.earliestDate();
    final start = first == null || since.isBefore(dateOnly(first))
        ? since
        : dateOnly(first);
    return start.isAfter(today) ? today : start;
  }

  /// A reset starts over from [day].
  Future<void> restart(DateTime day) =>
      _settings.write(BudgetKeys.trackingSince, dayKey(day));
}
