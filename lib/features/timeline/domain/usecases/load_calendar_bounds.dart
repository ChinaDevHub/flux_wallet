import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// From the day of the first recorded transaction (today when there is
/// none yet) to the end of the month three months ahead.
class LoadCalendarBounds {
  const LoadCalendarBounds(this._transactions, this._clock);

  final TransactionRepository _transactions;
  final Clock _clock;

  Future<CalendarBounds> call() async {
    final today = dateOnly(_clock());
    final first = await _transactions.earliestDate();
    final start = first == null ? today : dateOnly(first);
    return CalendarBounds(
      first: start.isAfter(today) ? today : start,
      last: CalendarBounds.lastDay(today),
    );
  }
}
