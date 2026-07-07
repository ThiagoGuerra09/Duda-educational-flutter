import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class SubjectCarouselCard extends StatelessWidget {
  const SubjectCarouselCard({
    required this.name,
    required this.classCount,
    super.key,
    this.onTap,
    this.accentColor,
  });

  final String name;
  final int classCount;
  final VoidCallback? onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: DudaCard(
        onTap: onTap,
        accentColor: accentColor ?? AppColors.primary,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DudaText.title(name, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppSpacing.sm),
            DudaText.caption('$classCount turmas'),
          ],
        ),
      ),
    );
  }
}
