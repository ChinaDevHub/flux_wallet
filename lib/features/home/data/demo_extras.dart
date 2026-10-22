import 'package:flux_wallet/core/di/app_dependencies.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';

/// Two debts and two unconfirmed bank messages for the demo database.
Future<void> seedDebtsAndNotifications(
  AppDependencies deps,
  DateTime now,
) async {
  final today = dateOnly(now);
  final u = deps.useCases;
  final account = (await deps.repos.accounts.getAll()).bankCard.id!;
  await u.createDebt(
    Debt(
      person: 'Kamal',
      amount: 50,
      direction: DebtDirection.borrowed,
      createdAt: now,
      dueDate: addDays(today, 6),
    ),
    accountId: account,
  );
  await u.createDebt(
    Debt(
      person: 'Aysel',
      amount: 120,
      direction: DebtDirection.lent,
      createdAt: now,
      dueDate: addDays(today, 20),
    ),
    accountId: account,
  );
  for (final text in const [
    'Kart +1234: BOLT.EU 4.80 AZN 08:42 ABB',
    'Kart +1234: MEGA_MARKET_BAKU 14.50 AZN · Kapital',
  ]) {
    await u.ingest(RawNotification(text: text, receivedAt: now));
  }
}
