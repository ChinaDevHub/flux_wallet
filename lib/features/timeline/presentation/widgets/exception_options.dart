import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/status_icons.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/sheet_option_tile.dart';

/// "Yalnız bu gün" / "Bu gündən sonrakı hamısı".
class ExceptionOptions extends StatelessWidget {
  const ExceptionOptions({
    super.key,
    required this.onOnce,
    required this.onFromHere,
  });

  final VoidCallback onOnce, onFromHere;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SheetOptionTile(
          icon: StatusIcons.today,
          title: 'Yalnız bu gün',
          subtitle: 'Digər günlər planda olduğu kimi qalır',
          onTap: onOnce,
        ),
        SheetOptionTile(
          icon: StatusIcons.dayOff,
          title: 'Bu gündən sonrakı hamısı',
          subtitle: 'Qayda bu gündən etibarən bitir',
          onTap: onFromHere,
        ),
      ],
    );
  }
}
