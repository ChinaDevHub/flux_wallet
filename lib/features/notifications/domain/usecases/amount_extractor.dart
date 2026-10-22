/// Money in AZN: "4.80 AZN", "4,80 ₼", "AZN 4.80", "1,200.00 AZN".
final _number = r'(\d{1,3}(?:,\d{3})+(?:\.\d{1,2})?|\d+(?:[.,]\d{1,2})?)';
final _after = RegExp('$_number\\s*(?:AZN|₼)', caseSensitive: false);
final _before = RegExp('(?:AZN|₼)\\s*$_number', caseSensitive: false);

/// Text after these words talks about the account, not the payment.
final _balanceTail = RegExp(
  r'(balans|balance|qalıq|qaliq|limit|остаток).*$',
  caseSensitive: false,
  dotAll: true,
);

String withoutBalance(String text) => text.replaceFirst(_balanceTail, '');

double? parseNumber(String raw) {
  final thousands = RegExp(r'^\d{1,3}(,\d{3})+(\.\d+)?$').hasMatch(raw);
  return double.tryParse(
    thousands ? raw.replaceAll(',', '') : raw.replaceAll(',', '.'),
  );
}

/// The first AZN amount of the payment itself, or null.
double? extractAmount(String text) {
  final clean = withoutBalance(text);
  final match = _after.firstMatch(clean) ?? _before.firstMatch(clean);
  final amount = match == null ? null : parseNumber(match.group(1)!);
  return amount != null && amount > 0 ? amount : null;
}

/// The matched "4.80 AZN" span, used to cut the merchant out of the text.
RegExpMatch? amountMatch(String text) =>
    _after.firstMatch(text) ?? _before.firstMatch(text);
