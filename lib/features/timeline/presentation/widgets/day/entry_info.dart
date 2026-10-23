import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/rule_schedule_label.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

/// The line inside an opened entry: how the rule repeats, or the category
/// and account of a recorded transaction.
String entryInfo(TimelineEntry e) {
  final rule = e.rule;
  if (rule == null) {
    final what = [CategoryStyle.of(e.category).label, ?e.account].join(' · ');
    return e.transaction?.debtId == null
        ? what
        : '$what · Borclar bölməsindən idarə olunur';
  }
  if (rule.id == null) return 'Borc ödənişi · Borclar bölməsindən idarə olunur';
  final label = ruleScheduleLabel(rule);
  return e.skipped ? '$label · bu gün söndürülüb' : label;
}
