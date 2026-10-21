import 'package:equatable/equatable.dart';

enum TipKind { shortfall, overspent, saving, onTrack }

class DailyTip extends Equatable {
  const DailyTip(this.kind, [this.amount = 0]);

  final TipKind kind;
  final double amount;

  @override
  List<Object?> get props => [kind, amount];
}
