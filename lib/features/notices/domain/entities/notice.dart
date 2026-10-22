import 'package:equatable/equatable.dart';

/// What needs the user's attention. Notices are derived from the user's
/// data, never stored, so one disappears as soon as it is dealt with.
enum NoticeKind {
  /// Bank messages waiting for "Təsdiqlə".
  bankMessages,

  /// A bill (rent, utilities, ...) falls due soon.
  paymentDue,

  /// A debt I owe is due soon or overdue.
  debtDue,

  /// Someone has not paid me back on time.
  debtOwed,
}

class Notice extends Equatable {
  const Notice(
    this.kind, {
    this.subject = '',
    this.amount = 0,
    this.days = 0,
    this.count = 0,
  });

  final NoticeKind kind;

  /// The bill's title, or the person of a debt.
  final String subject;
  final double amount;

  /// Days until it is due; negative once overdue.
  final int days;

  /// Number of waiting bank messages.
  final int count;

  @override
  List<Object?> get props => [kind, subject, amount, days, count];
}
