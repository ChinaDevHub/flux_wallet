import 'package:flux_wallet/features/notifications/domain/usecases/amount_extractor.dart';

final _cardPrefix = RegExp(
  r'(?:kart|card)\s*[+*]?\s*\d{2,4}\s*[:\-]\s*',
  caseSensitive: false,
);
final _atKeyword = RegExp(
  r'(?:\bat\b|@|satıcı|merchant|yer)\s*[:\-]?\s*([^.,\n]+)',
  caseSensitive: false,
);
final _noise = RegExp(
  r'(\d{1,2}[.:]\d{1,2}([.:]\d{2,4})?|\bkart\b|\bcard\b|\bödəniş\b|\bpurchase\b|'
  r'\bpayment\b|\bAZN\b|₼|[+*]?\d{4}\b|[:·|•])',
  caseSensitive: false,
);

String _tidy(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

/// The shop / service name, or null when the text does not reveal one.
String? extractMerchant(String text) {
  final clean = withoutBalance(text);
  final amount = amountMatch(clean);
  final prefix = _cardPrefix.firstMatch(clean);
  if (prefix != null && amount != null && amount.start > prefix.end) {
    final between = clean.substring(prefix.end, amount.start);
    // "purchase 12.50 AZN at BRAVO": the words before the amount are noise.
    final name = _nonEmpty(between.replaceAll(_noise, ' '));
    if (name != null) return name;
  }
  final at = _atKeyword.firstMatch(clean);
  if (at != null) return _nonEmpty(at.group(1)!);
  final rest = amount == null
      ? clean
      : clean.replaceRange(amount.start, amount.end, ' ');
  return _nonEmpty(rest.replaceAll(_noise, ' '));
}

String? _nonEmpty(String s) {
  final value = _tidy(s);
  return value.length < 2 ? null : value;
}
