import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/class_detail_cubit.dart';
import 'package:duda_educational_flutter/features/classes/presentation/cubit/class_detail_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_app_bar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_error_state.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_list_tile.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_loading.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_scaffold.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';
import 'package:duda_educational_flutter/shared/widgets/assignment_card.dart';

class ClassDetailPage extends StatefulWidget {
  const ClassDetailPage({required this.classId, super.key});

  final String classId;

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClassDetailCubit>().loadDetail(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return DudaScaffold(
      appBar: const DudaAppBar(title: 'Detalhes da Turma'),
      body: BlocBuilder<ClassDetailCubit, ClassDetailState>(
        builder: (context, state) {
          return switch (state.status) {
            ClassDetailStatus.initial || ClassDetailStatus.loading =>
              const DudaLoading.skeleton(itemCount: 3),
            ClassDetailStatus.failure => DudaErrorState(
                message: state.errorMessage ?? 'Erro ao carregar detalhes',
                onRetry: () =>
                    context.read<ClassDetailCubit>().loadDetail(widget.classId),
              ),
            ClassDetailStatus.success => _DetailContent(detail: state.detail!),
          };
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail});

  final ClassDetail detail;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        DudaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DudaText.title(detail.name),
              const SizedBox(height: AppSpacing.sm),
              DudaText.body(detail.semester, color: AppColors.textSecondary),
              const SizedBox(height: AppSpacing.md),
              DudaText.caption('Horário: ${detail.schedule}'),
              DudaText.caption('Local: ${detail.location}'),
              DudaText.caption('Média: ${detail.averageGrade}'),
              DudaText.caption('Frequência: ${detail.attendanceRate}'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const DudaText.label('MATERIAIS'),
        ...detail.materials.map<Widget>(
          (material) => DudaListTile(
            leading: Icon(
              material.icon == 'list' ? Icons.list : Icons.download,
              color: AppColors.primary,
            ),
            title: DudaText.body(material.title),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const DudaText.label('ATIVIDADES'),
        ...detail.activities.map<Widget>(
          (activity) => AssignmentCard(
            title: activity.title,
            dueDate: activity.dueDate,
            status: activity.status,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const DudaText.label('ALUNOS'),
        ...detail.students.map<Widget>(
          (student) => DudaListTile(
            title: DudaText.body(student.name),
            subtitle: DudaText.caption('Matrícula: ${student.registration}'),
          ),
        ),
      ],
    );
  }
}
