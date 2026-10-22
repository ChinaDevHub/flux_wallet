import 'package:flux_wallet/features/auth/domain/entities/user.dart';

extension UserCopy on User {
  User copyWith({
    String? fullName,
    String? username,
    String? passwordHash,
    String? passwordHint,
    String? avatarUrl,
    bool clearHint = false,
  }) => User(
    id: id,
    username: username ?? this.username,
    passwordHash: passwordHash ?? this.passwordHash,
    passwordHint: clearHint ? null : passwordHint ?? this.passwordHint,
    fullName: fullName ?? this.fullName,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    createdAt: createdAt,
  );
}
