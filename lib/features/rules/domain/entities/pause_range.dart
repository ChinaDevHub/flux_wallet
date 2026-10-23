import 'package:equatable/equatable.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// Days a rule was (or is) switched off: [from] to [to] inclusive, or with
/// no [to] until it is switched on again.
class PauseRange extends Equatable {
  const PauseRange(this.from, [this.to]);

  final DateTime from;
  final DateTime? to;

  bool covers(DateTime day) {
    final d = dateOnly(day);
    return !d.isBefore(from) && (to == null || !d.isAfter(to!));
  }

  @override
  List<Object?> get props => [from, to];
}
