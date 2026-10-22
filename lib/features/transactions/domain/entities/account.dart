import 'package:equatable/equatable.dart';

enum AccountType { card, cash }

class Account extends Equatable {
  const Account({
    this.id,
    required this.name,
    required this.balance,
    required this.type,
  });

  final int? id;
  final String name;
  final double balance;
  final AccountType type;

  @override
  List<Object?> get props => [id, name, balance, type];
}

extension AccountListX on List<Account> {
  /// Bank messages are card payments; fall back to the first account.
  Account get bankCard =>
      firstWhere((a) => a.type == AccountType.card, orElse: () => first);
}
