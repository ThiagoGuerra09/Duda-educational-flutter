import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/classes_cubit.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/classes_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_container.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key, this.onClassTap});

  final ValueChanged<ClassEntity>? onClassTap;

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  static const _disciplines = [
    _DisciplineItem(
      name: 'Enfermagem',
      classCount: 4,
      icon: Icons.medical_services_outlined,
      color: Color(0xFF2B6CB0),
    ),
    _DisciplineItem(
      name: 'Computação',
      classCount: 3,
      icon: Icons.computer_outlined,
      color: Color(0xFFEC4899),
    ),
    _DisciplineItem(
      name: 'Administração',
      classCount: 2,
      icon: Icons.business_center_outlined,
      color: Color(0xFFEAB308),
    ),
    _DisciplineItem(
      name: 'Direito',
      classCount: 2,
      icon: Icons.gavel_outlined,
      color: Color(0xFF7C3AED),
    ),
    _DisciplineItem(
      name: 'Pedagogia',
      classCount: 3,
      icon: Icons.school_outlined,
      color: Color(0xFF22C55E),
    ),
    _DisciplineItem(
      name: 'Engenharia',
      classCount: 2,
      icon: Icons.precision_manufacturing_outlined,
      color: Color(0xFFF97316),
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ClassesCubit>().loadClasses();
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: DudaAppBar(
        title: 'Disciplinas',
        actions: DudaHeaderActions.notificationsAndChat(context),
      ),
      body: BlocBuilder<ClassesCubit, ClassesState>(
        builder: (context, state) {
          return switch (state.status) {
            ClassesStatus.initial || ClassesStatus.loading =>
              const DudaLoading.skeleton(itemCount: 4),
            ClassesStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar disciplinas',
                onRetry: () => context.read<ClassesCubit>().loadClasses(),
              ),
            ClassesStatus.success => ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  _AgendaCard(onTap: () => context.push(AppRoutes.schedule)),
                  const SizedBox(height: AppSpacing.xl),
                  const DudaText.label('DISCIPLINAS'),
                  const SizedBox(height: AppSpacing.md),
                  _DisciplinesGrid(
                    disciplines: _disciplines,
                    onDisciplineTap: (discipline) => DudaScaffold.showSnackBar(
                      context,
                      '${discipline.name} — ${discipline.classCount} turmas ativas',
                    ),
                  ),
                  if (state.classes.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xl),
                    const DudaText.label('MINHAS TURMAS'),
                    const SizedBox(height: AppSpacing.md),
                    ...state.classes.map((classItem) {
                      return DudaCard(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        accentColor: classItem.accentColor,
                        onTap: () {
                          widget.onClassTap?.call(classItem);
                          context.push('/classes/${classItem.id}');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DudaText.title(classItem.name),
                            const SizedBox(height: AppSpacing.xs),
                            DudaText.caption(classItem.course),
                            const SizedBox(height: AppSpacing.sm),
                            DudaText.body(
                              classItem.schedule,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                DudaTag(
                                  label: '${classItem.studentCount} alunos',
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                DudaTag(
                                  label: classItem.status,
                                  color: classItem.status == 'active'
                                      ? AppColors.success
                                      : AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
          };
        },
      ),
    );
  }
}

class _DisciplineItem {
  const _DisciplineItem({
    required this.name,
    required this.classCount,
    required this.icon,
    required this.color,
  });

  final String name;
  final int classCount;
  final IconData icon;
  final Color color;
}

class _DisciplinesGrid extends StatelessWidget {
  const _DisciplinesGrid({
    required this.disciplines,
    required this.onDisciplineTap,
  });

  final List<_DisciplineItem> disciplines;
  final ValueChanged<_DisciplineItem> onDisciplineTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.md;
        final itemWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: disciplines.map((discipline) {
            return SizedBox(
              width: itemWidth,
              child: _DisciplineCard(
                discipline: discipline,
                onTap: () => onDisciplineTap(discipline),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _DisciplineCard extends StatelessWidget {
  const _DisciplineCard({
    required this.discipline,
    required this.onTap,
  });

  final _DisciplineItem discipline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: DudaContainer(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: discipline.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(discipline.icon, color: discipline.color, size: 24),
              ),
              const SizedBox(height: AppSpacing.md),
              DudaText.title(discipline.name),
              const SizedBox(height: AppSpacing.xs),
              DudaText.caption('${discipline.classCount} turmas'),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DudaCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.welcomeCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(child: DudaText.title('Agenda')),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
