import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

/// "Kart", "Nağd · Bildirişdən": which account the money moved through and,
/// when it came from a bank message, how it was logged.
String transactionSubtitle(Transaction t, List<Account> accounts) => [
  accounts.nameOf(t.accountId) ?? 'Hesab',
  if (t.source == TxSource.notification) 'Bildirişdən',
].join(' · ');
