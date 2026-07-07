import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({
    required this.title,
    required this.dueDate,
    super.key,
    this.status,
    this.onTap,
  });

  final String title;
  final String dueDate;
  final String? status;
  final VoidCallback? onTap;

  Color get _statusColor => switch (status) {
        'pending' => AppColors.warning,
        'scheduled' => AppColors.secondary,
        'completed' => AppColors.success,
        _ => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return DudaCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(Icons.assignment_outlined, color: _statusColor),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DudaText.body(title),
                DudaText.caption('Entrega: $dueDate'),
              ],
            ),
          ),
          if (status != null) DudaTag(label: status!, color: _statusColor),
        ],
      ),
    );
  }
}
