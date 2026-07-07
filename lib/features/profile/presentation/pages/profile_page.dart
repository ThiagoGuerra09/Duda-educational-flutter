import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:duda_educational_flutter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:duda_educational_flutter/features/profile/presentation/cubit/profile_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_avatar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_button.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.onLogout});

  final VoidCallback? onLogout;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  Future<void> _handleLogout() async {
    await context.read<AuthCubit>().logout();
    widget.onLogout?.call();
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: DudaAppBar(
        title: 'Meu Perfil',
        actions: DudaHeaderActions.notificationsAndChat(context),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state.status) {
            ProfileStatus.initial || ProfileStatus.loading =>
              const DudaLoading.skeleton(itemCount: 3),
            ProfileStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar perfil',
                onRetry: () => context.read<ProfileCubit>().loadProfile(),
              ),
            ProfileStatus.success => ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  DudaCard(
                    child: Column(
                      children: [
                        DudaAvatar(
                          initials: state.profile!.initials,
                          imageUrl: state.profile!.photoUrl,
                          size: 72,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        DudaText.title(state.profile!.name),
                        const SizedBox(height: AppSpacing.xs),
                        DudaText.body(
                          state.profile!.email,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        DudaText.caption(state.profile!.department),
                        DudaText.caption(state.profile!.campus),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DudaCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DudaText.label('SOBRE'),
                        const SizedBox(height: AppSpacing.sm),
                        DudaText.body(state.profile!.bio),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const DudaText.label('DISCIPLINAS'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: state.profile!.subjects
                        .map((subject) => DudaTag(label: subject))
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  DudaButton(
                    label: 'Sair',
                    variant: DudaButtonVariant.outlined,
                    icon: Icons.logout,
                    onPressed: _handleLogout,
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
