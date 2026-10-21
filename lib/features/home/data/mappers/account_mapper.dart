import 'package:flux_wallet/features/home/domain/entities/account.dart';

extension AccountMapper on Account {
  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'balance': balance,
    'type': type.name,
  };
}

Account accountFromMap(Map<String, Object?> m) => Account(
  id: m['id'] as int,
  name: m['name'] as String,
  balance: (m['balance'] as num).toDouble(),
  type: AccountType.values.byName(m['type'] as String),
);
