import 'package:equatable/equatable.dart';

/// The stretch between the previous and the next income.
class IncomeCycle extends Equatable {
  const IncomeCycle({
    required this.date,
    required this.title,
    required this.daysLeft,
    required this.progress,
  });

  final DateTime date;
  final String title;
  final int daysLeft;

  /// 0..1 share of the cycle that has already passed.
  final double progress;

  @override
  List<Object?> get props => [date, title, daysLeft, progress];
}
