import 'package:flux_wallet/features/notifications/domain/repositories/merchant_repository.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/merchant_hints.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/merchant_key.dart';

/// What the user chose last time, else a built-in guess, else nothing.
class SuggestCategory {
  const SuggestCategory(this._merchants);

  final MerchantRepository _merchants;

  Future<String?> call(String merchant) async {
    final key = merchantKey(merchant);
    return await _merchants.categoryFor(key) ?? hintCategory(key);
  }
}
