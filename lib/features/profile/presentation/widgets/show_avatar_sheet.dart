import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/avatar_picker_sheet.dart';

void showAvatarSheet(BuildContext context, ProfileCubit cubit) {
  showAppSheet<void>(
    context,
    (ctx) => AvatarPickerSheet(
      onPreset: (i) {
        Navigator.pop(ctx);
        cubit.choosePreset(i);
      },
      onGallery: () {
        Navigator.pop(ctx);
        cubit.choosePhoto();
      },
    ),
  );
}
