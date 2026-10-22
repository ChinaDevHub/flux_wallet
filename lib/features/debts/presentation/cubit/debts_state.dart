import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debts_overview.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

sealed class DebtsState extends Equatable {
  const DebtsState();

  @override
  List<Object?> get props => const [];
}

class DebtsLoading extends DebtsState {
  const DebtsLoading();
}

class DebtsFailure extends DebtsState {
  const DebtsFailure();
}

class DebtsLoaded extends DebtsState {
  const DebtsLoaded(this.overview, this.direction, this.accounts);

  final DebtsOverview overview;
  final DebtDirection direction;
  final List<Account> accounts;

  @override
  List<Object?> get props => [overview, direction, accounts];
}
