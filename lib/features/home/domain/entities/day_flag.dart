import 'package:equatable/equatable.dart';

/// "İşə getmirəm" switch: weekday rules are skipped on flagged days.
class DayFlag extends Equatable {
  const DayFlag({this.id, required this.date, required this.isNotWorkingDay});

  final int? id;
  final DateTime date;
  final bool isNotWorkingDay;

  @override
  List<Object?> get props => [id, date, isNotWorkingDay];
}
