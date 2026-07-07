import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    super.key,
    this.type,
    this.onTap,
  });

  final String title;
  final String startTime;
  final String endTime;
  final String location;
  final String? type;
  final VoidCallback? onTap;

  Color get _typeColor => switch (type) {
        'aula' => AppColors.primary,
        'prova' => AppColors.error,
        'reuniao' => AppColors.secondary,
        'prazo' => AppColors.warning,
        _ => AppColors.primary,
      };

  @override
  Widget build(BuildContext context) {
    return DudaCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      accentColor: _typeColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: DudaText.title(title)),
              if (type != null) DudaTag(label: type!, color: _typeColor),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          DudaText.body('$startTime - $endTime'),
          DudaText.caption(location),
        ],
      ),
    );
  }
}
