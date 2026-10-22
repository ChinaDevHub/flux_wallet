import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/bank_message_parser.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

void main() {
  const parse = BankMessageParser();
  final now = DateTime(2026, 10, 20, 9);

  test('bank-app style: card prefix, merchant, amount, date and time', () {
    final m = parse('Kart +1234: BOLT.EU 4.80 AZN 20.10 08:42 ABB', now)!;
    expect(m.merchant, 'BOLT.EU');
    expect(m.amount, 4.8);
    expect(m.type, TxType.expense);
    expect(m.occurredAt, DateTime(2026, 10, 20, 8, 42));
  });

  test('merchant with underscores and no date', () {
    final m = parse('Kart +1234: MEGA_MARKET_BAKU 14.50 AZN · Kapital', now)!;
    expect(m.merchant, 'MEGA_MARKET_BAKU');
    expect(m.amount, 14.5);
    expect(m.occurredAt, isNull);
  });

  test('English text, comma decimals and a balance that must be ignored', () {
    final m = parse(
      'Card *4321: purchase 12,50 AZN at BRAVO MARKET. Balance: 300.00 AZN',
      now,
    )!;
    expect(m.amount, 12.5);
    expect(m.merchant, 'BRAVO MARKET');
  });

  test('thousands separators and the symbol before the number', () {
    expect(parse('Maaş daxil oldu: 1,200.00 AZN', now)!.amount, 1200);
    expect(parse('Ödəniş AZN 5.60 SHELL STATION', now)!.amount, 5.6);
  });

  test('incoming money is income', () {
    final m = parse('Hesabınıza 50.00 AZN daxil oldu. Kamal', now)!;
    expect(m.type, TxType.income);
    expect(m.amount, 50);
  });

  test('full date with year and a date-only message', () {
    expect(
      parse('SHELL 22.00 AZN 18.10.2026 14:03', now)!.occurredAt,
      DateTime(2026, 10, 18, 14, 3),
    );
    expect(
      parse('SHELL 22.00 AZN 18.10.2026', now)!.occurredAt,
      DateTime(2026, 10, 18, 12),
    );
  });

  test('a date in the future of a yearless message belongs to last year', () {
    final m = parse('Kart +1234: BOLT.EU 4.80 AZN 25.12 08:42', now)!;
    expect(m.occurredAt, DateTime(2025, 12, 25, 8, 42));
  });

  test('other currencies and plain chats are ignored', () {
    expect(parse('Card *1234: AMAZON 10.00 USD', now), isNull);
    expect(parse('Salam, necəsən?', now), isNull);
  });

  test('unknown merchant falls back to a label', () {
    expect(
      parse('12.00 AZN', now)!.merchant,
      BankMessageParser.unknownMerchant,
    );
  });
}
