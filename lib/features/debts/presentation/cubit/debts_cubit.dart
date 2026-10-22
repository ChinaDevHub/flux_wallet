import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/debts/domain/entities/debts_overview.dart';
import 'package:flux_wallet/features/debts/domain/repositories/debt_repository.dart';
import 'package:flux_wallet/features/debts/domain/usecases/record_debt_payment.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/debts_state.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';

class DebtsCubit extends ReloadingCubit<DebtsState> {
  DebtsCubit(this._debts, this._pay, this._accounts, Stream<void> changes)
    : super(const DebtsLoading(), changes);

  final DebtRepository _debts;
  final RecordDebtPayment _pay;
  final AccountRepository _accounts;
  DebtDirection _direction = DebtDirection.borrowed;

  @override
  Future<void> load() async {
    try {
      emit(
        DebtsLoaded(
          DebtsOverview(await _debts.getAll()),
          _direction,
          await _accounts.getAll(),
        ),
      );
    } catch (_) {
      emit(const DebtsFailure());
    }
  }

  Future<void> select(DebtDirection direction) {
    _direction = direction;
    return load();
  }

  Future<void> pay(DebtSummary summary, double amount, int accountId) =>
      _pay(summary, amount, accountId);

  Future<void> delete(DebtSummary summary) => _debts.delete(summary.debt.id!);
}
