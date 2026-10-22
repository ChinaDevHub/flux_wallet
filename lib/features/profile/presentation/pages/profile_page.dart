import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_loader.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_state.dart';
import 'package:flux_wallet/features/profile/presentation/widgets/profile_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) => state.user == null
              ? const Center(child: AdaptiveLoader())
              : ProfileBody(user: state.user!),
        ),
      ),
    );
  }
}
