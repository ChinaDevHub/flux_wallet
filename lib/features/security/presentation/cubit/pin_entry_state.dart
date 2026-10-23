import 'package:equatable/equatable.dart';

/// The digits typed so far on a PIN pad.
class PinEntryState extends Equatable {
  const PinEntryState({required this.length, this.digits = ''});

  final int length;
  final String digits;

  bool get isComplete => digits.length == length;
  bool get isEmpty => digits.isEmpty;

  @override
  List<Object?> get props => [length, digits];
}
