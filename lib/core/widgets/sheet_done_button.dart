import 'package:flutter/cupertino.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// "Hazır" under an iOS wheel: closes the sheet with [result].
class SheetDoneButton<T> extends StatelessWidget {
  const SheetDoneButton({super.key, required this.result});

  final T Function() result;

  @override
  Widget build(BuildContext context) => CupertinoButton(
    onPressed: () => Navigator.pop(context, result()),
    child: Text('Hazır', style: TextStyle(color: context.colors.primary)),
  );
}
