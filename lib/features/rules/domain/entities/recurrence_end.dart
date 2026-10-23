import 'package:equatable/equatable.dart';

/// When a recurring rule stops: never, after so many times, or on a date.
sealed class RecurrenceEnd extends Equatable {
  const RecurrenceEnd();

  static const never = NeverEnds();

  @override
  List<Object?> get props => const [];
}

class NeverEnds extends RecurrenceEnd {
  const NeverEnds();
}

/// "4 dəfə": [count] occurrences, the first one (the recorded transaction)
/// included, so a 4-month credit entered today ends in 3 months.
class EndsAfter extends RecurrenceEnd {
  const EndsAfter(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

class EndsOn extends RecurrenceEnd {
  const EndsOn(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}
