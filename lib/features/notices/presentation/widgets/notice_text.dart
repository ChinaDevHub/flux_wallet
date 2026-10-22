import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';

/// The words of a notice, in Azerbaijani.
extension NoticeText on Notice {
  String get title => switch (kind) {
    NoticeKind.bankMessages => '$count bank bildirişi təsdiq gözləyir',
    NoticeKind.paymentDue => subject,
    NoticeKind.debtDue => '$subject · borc ödənişi',
    NoticeKind.debtOwed => '$subject borcunu qaytarmayıb',
  };

  String get detail => kind == NoticeKind.bankMessages
      ? 'Kateqoriyanı yoxla və təsdiqlə'
      : '${_when(days)} · ${formatAzn(amount)}';
}

String _when(int days) => switch (days) {
  < 0 => '${-days} gün gecikib',
  0 => 'Bu gün',
  1 => 'Sabah',
  _ => '$days gün sonra',
};
