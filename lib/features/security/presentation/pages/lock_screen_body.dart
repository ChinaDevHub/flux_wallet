import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/security/presentation/cubit/app_lock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/unlock_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/unlock_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/lock_footer.dart';
import 'package:flux_wallet/features/security/presentation/widgets/lock_header.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_prompt.dart';

class LockScreenBody extends StatelessWidget {
  const LockScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final lock = context.watch<AppLockCubit>().state;
    final name = lock.user?.firstName;
    return BlocBuilder<UnlockCubit, UnlockState>(
      builder: (context, s) => Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: PinEntryView(
            key: ValueKey(lock.pinLength),
            length: lock.pinLength,
            prompt: PinPrompt(
              title: name == null ? 'Salam' : 'Salam, $name',
              subtitle: 'Davam etmək üçün PIN kodu daxil et',
              caption: s.caption,
              captionError: true,
            ),
            header: LockHeader(user: lock.user),
            resetTick: s.failures,
            enabled: !s.blocked && !s.checking,
            onFilled: context.read<UnlockCubit>().submit,
            footer: const LockFooter(),
          ),
        ),
      ),
    );
  }
}
