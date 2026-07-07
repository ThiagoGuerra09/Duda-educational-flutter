import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';

enum DudaLoadingType { circular, linear, skeleton }

class DudaLoading extends StatelessWidget {
  const DudaLoading({
    super.key,
    this.type = DudaLoadingType.circular,
    this.itemCount = 3,
  });

  const DudaLoading.skeleton({super.key, this.itemCount = 3})
      : type = DudaLoadingType.skeleton;

  const DudaLoading.circular({super.key}) : type = DudaLoadingType.circular, itemCount = 3;

  final DudaLoadingType type;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      DudaLoadingType.circular => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      DudaLoadingType.linear => const LinearProgressIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.border,
        ),
      // ExcludeSemantics: skeletons são decorativos; sem isso, o shimmer
      // gera nós de semântica instáveis que podem crashar no iOS (semântica
      // ativa por padrão no simulador).
      DudaLoadingType.skeleton => ExcludeSemantics(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: itemCount,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, _) => const _SkeletonCard(),
          ),
        ),
    };
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.surface,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: AppRadius.mediumAll,
        ),
      ),
    );
  }
}
