const azn = '₼';

/// 1234.5 -> "1,234.50"
String formatMoney(double value) {
  final fixed = value.abs().toStringAsFixed(2).split('.');
  final grouped = fixed.first.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return '$grouped.${fixed.last}';
}

/// 1234.5 -> "1,234.50 ₼"; negative values get a leading minus.
String formatAzn(double value, {bool signed = false}) {
  final sign = value < 0 ? '-' : (signed && value > 0 ? '+' : '');
  return '$sign${formatMoney(value)} $azn';
}

/// Accepts "12,5" and "12.5"; returns null for blank/invalid input.
double? parseMoney(String raw) {
  final text = raw.trim().replaceAll(',', '.');
  return text.isEmpty ? null : double.tryParse(text);
}

/// Rounds towards zero to 2 decimals so the limit never overspends.
double floorCents(double value) => (value * 100).floorToDouble() / 100;
