import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Activity indicator on iOS, circular progress on Android.
class AdaptiveLoader extends StatelessWidget {
  const AdaptiveLoader({super.key, this.size = 28, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? context.colors.primary;
    return SizedBox.square(
      dimension: size,
      child: context.isCupertino
          ? CupertinoActivityIndicator(color: tint, radius: size / 2)
          : CircularProgressIndicator(strokeWidth: 2.6, color: tint),
    );
  }
}
