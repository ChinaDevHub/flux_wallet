import 'package:flux_wallet/core/widgets/category_style.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';

extension EntryLabel on TimelineEntry {
  /// The note / rule title, falling back to the category name.
  String get label => title ?? CategoryStyle.of(category).label;
}
