import 'package:equatable/equatable.dart';

/// What the database keeps of a PIN: its salted hash and how many digits it
/// has (so the pad knows when to check).
class StoredPin extends Equatable {
  const StoredPin({required this.hash, required this.length});

  final String hash;
  final int length;

  @override
  List<Object?> get props => [hash, length];
}
