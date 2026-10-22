abstract interface class MerchantRepository {
  Future<String?> categoryFor(String merchantKey);
  Future<void> remember(String merchantKey, String category);
}
