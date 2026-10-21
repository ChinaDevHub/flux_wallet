import 'package:flux_wallet/features/home/domain/entities/account.dart';

abstract interface class AccountRepository {
  Future<List<Account>> getAll();
  Future<int> add(Account account);
}
