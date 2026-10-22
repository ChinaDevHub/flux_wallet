import 'package:flux_wallet/features/auth/domain/entities/user.dart';

extension UserMapper on User {
  Map<String, Object?> toMap() => {
    'id': id,
    'username': username,
    'password_hash': passwordHash,
    'password_hint': passwordHint,
    'full_name': fullName,
    'avatar_url': avatarUrl,
    'created_at': createdAt.toIso8601String(),
  };
}

User userFromMap(Map<String, Object?> m) => User(
  id: m['id'] as String,
  username: m['username'] as String,
  passwordHash: m['password_hash'] as String,
  passwordHint: m['password_hint'] as String?,
  fullName: m['full_name'] as String,
  avatarUrl: m['avatar_url'] as String?,
  createdAt: DateTime.parse(m['created_at'] as String),
);
