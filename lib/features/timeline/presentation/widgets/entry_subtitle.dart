import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

extension EntrySubtitle on TimelineEntry {
  /// Planned lines say so; real ones say which account the money moved
  /// through (Kart / Nağd).
  String? get subtitle {
    if (!isVirtual) return account;
    return rule?.category == 'debt' ? 'Borc ödənişi' : 'Avtomatik plan';
  }
}
