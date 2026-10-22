import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Cupertino modal popup on iOS, Material bottom sheet on Android.
Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) {
  if (context.isCupertino) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (ctx) => _SheetFrame(child: _KeyboardInset(builder(ctx))),
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: context.colors.surface,
    builder: (ctx) => _KeyboardInset(builder(ctx)),
  );
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(top: false, child: child),
    );
  }
}

/// Lifts the sheet's content above the on-screen keyboard.
class _KeyboardInset extends StatelessWidget {
  const _KeyboardInset(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: child,
  );
}
