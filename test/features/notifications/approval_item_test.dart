import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_view.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_draft.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

void main() {
  final bus = RecurringRule(
    id: 1,
    title: 'Avtobus',
    amount: 1,
    category: 'bus',
    frequency: Frequency.weekdays,
    startDate: DateTime(2026, 1, 1),
  );
  PendingView view({String? category = 'taxi', RecurringRule? replaceable}) =>
      PendingView(
        pending: PendingTransaction(
          id: 1,
          fingerprint: 'f',
          rawText: 'raw',
          merchant: 'BOLT.EU',
          amount: 4.8,
          type: TxType.expense,
          occurredAt: DateTime(2026, 10, 20),
          category: category,
        ),
        replaceableBus: replaceable,
      );

  test('the suggested category is the default; a draft overrides it', () {
    expect(ApprovalItem.from(view(), null).category, 'taxi');
    final drafted = ApprovalItem.from(
      view(),
      const ApprovalDraft(category: 'cafe'),
    );
    expect(drafted.category, 'cafe');
  });

  test('the bus question is only for a taxi on a day with a planned fare', () {
    expect(
      ApprovalItem.from(view(replaceable: bus), null).asksAboutBus,
      isTrue,
    );
    expect(ApprovalItem.from(view(), null).asksAboutBus, isFalse);
    final cafe = ApprovalItem.from(
      view(category: 'cafe', replaceable: bus),
      null,
    );
    expect(cafe.asksAboutBus, isFalse);
  });

  test('confirming needs a category and, when asked, an answer', () {
    expect(ApprovalItem.from(view(category: null), null).canConfirm, isFalse);
    expect(ApprovalItem.from(view(), null).canConfirm, isTrue);
    final asked = ApprovalItem.from(view(replaceable: bus), null);
    expect(asked.canConfirm, isFalse);
    final answered = ApprovalItem.from(
      view(replaceable: bus),
      const ApprovalDraft(replaceBus: false),
    );
    expect(answered.canConfirm, isTrue);
  });
}
