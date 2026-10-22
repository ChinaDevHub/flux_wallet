import 'package:flux_wallet/features/notifications/domain/entities/parsed_bank_message.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/amount_extractor.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/direction_detector.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/merchant_extractor.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/occurred_at_extractor.dart';

/// Turns a bank text into amount + merchant + time. Only AZN is understood;
/// anything else (other currencies, chat messages) returns null.
class BankMessageParser {
  const BankMessageParser();

  static const unknownMerchant = 'Naməlum';

  ParsedBankMessage? call(String text, DateTime receivedAt) {
    final amount = extractAmount(text);
    if (amount == null) return null;
    return ParsedBankMessage(
      amount: amount,
      merchant: extractMerchant(text) ?? unknownMerchant,
      type: detectDirection(text),
      occurredAt: extractOccurredAt(text, receivedAt),
    );
  }
}
