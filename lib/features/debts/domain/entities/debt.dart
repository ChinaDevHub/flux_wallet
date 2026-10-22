import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';

class Debt extends Equatable {
  const Debt({
    this.id,
    required this.person,
    required this.amount,
    required this.direction,
    required this.createdAt,
    this.dueDate,
    this.note,
    this.isClosed = false,
  });

  final int? id;
  final String person;
  final double amount;
  final DebtDirection direction;
  final DateTime createdAt;

  /// Required for [DebtDirection.borrowed]: when the money must be returned.
  final DateTime? dueDate;
  final String? note;
  final bool isClosed;

  Debt withCreatedAt(DateTime at) => Debt(
    id: id,
    person: person,
    amount: amount,
    direction: direction,
    createdAt: at,
    dueDate: dueDate,
    note: note,
    isClosed: isClosed,
  );

  @override
  List<Object?> get props => [
    id,
    person,
    amount,
    direction,
    createdAt,
    dueDate,
    note,
    isClosed,
  ];
}
