import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.fullName,
    required this.createdAt,
    this.passwordHint,
    this.avatarUrl,
  });

  /// UUID.
  final String id;

  /// Normalised: trimmed and lower-case, unique.
  final String username;
  final String passwordHash;
  final String? passwordHint;
  final String fullName;

  /// A built-in avatar (`preset:3`) or the path of a picked photo.
  final String? avatarUrl;
  final DateTime createdAt;

  String get firstName => fullName.trim().split(RegExp(r'\s+')).first;

  @override
  List<Object?> get props => [
    id,
    username,
    passwordHash,
    passwordHint,
    fullName,
    avatarUrl,
    createdAt,
  ];
}
