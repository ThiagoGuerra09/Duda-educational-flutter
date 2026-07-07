import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:duda_educational_flutter/features/home/presentation/cubit/home_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_avatar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_container.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';
import 'package:duda_educational_flutter/shared/widgets/quick_access_card.dart';
import 'package:duda_educational_flutter/shared/widgets/subject_carousel_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHome();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: DudaAppBar(
        title: 'Início',
        actions: DudaHeaderActions.notificationsAndChat(context),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state.status) {
            HomeStatus.initial || HomeStatus.loading =>
              const DudaLoading.skeleton(itemCount: 5),
            HomeStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar',
                onRetry: () => context.read<HomeCubit>().loadHome(),
              ),
            HomeStatus.loaded => RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().loadHome(refresh: true),
                child: _HomeContent(
                  data: state.data!,
                  pageController: _pageController,
                  currentPage: _currentPage,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                ),
              ),
          };
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.data,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
  });

  final HomeData data;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        DudaAvatarRow(
          name: 'Olá, ${data.professorName}',
          subtitle: data.welcomeMessage,
          initials: data.initials,
          heroTag: 'professor-avatar',
        ),
        const SizedBox(height: AppSpacing.xl),
        const DudaContainer(
          backgroundColor: AppColors.welcomeCard,
          boxShadow: [],
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Icon(Icons.school, size: 48, color: AppColors.secondary),
              SizedBox(height: AppSpacing.md),
              DudaText.title('Boas-vindas ao Duda Educador!'),
              SizedBox(height: AppSpacing.sm),
              DudaText.body(
                'Facilitador do seu dia a dia',
                textAlign: TextAlign.center,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        DudaText.label('MINHAS DISCIPLINAS (${data.subjects.length})'),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: data.subjects.length,
            itemBuilder: (context, index) {
              final subject = data.subjects[index];
              return SubjectCarouselCard(
                name: subject.name,
                classCount: subject.classCount,
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            data.subjects.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        if (data.nextClassSubject != null) ...[
          const SizedBox(height: AppSpacing.xl),
          const DudaText.label('PRÓXIMA AULA'),
          const SizedBox(height: AppSpacing.md),
          DudaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DudaText.title(data.nextClassSubject!),
                const SizedBox(height: AppSpacing.xs),
                DudaText.body(
                  '${data.nextClassTime} • ${data.nextClassRoom}',
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        const DudaText.label('PENDÊNCIAS'),
        const SizedBox(height: AppSpacing.md),
        DudaCard(
          child: Row(
            children: [
              const Icon(Icons.assignment_outlined, color: AppColors.warning),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: DudaText.body(
                  '${data.pendingAssignments} atividades pendentes de correção',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const DudaText.label('ACESSO RÁPIDO'),
        const SizedBox(height: AppSpacing.md),
        ...data.quickAccess.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: QuickAccessCard(title: item.title, subtitle: item.subtitle),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: () => context.go(AppRoutes.profile),
          child: const DudaText.body(
            'Meu Perfil de Educador →',
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
