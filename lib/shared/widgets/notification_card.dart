import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    super.key,
    this.isRead = false,
    this.onTap,
  });

  final String title;
  final String body;
  final String category;
  final String date;
  final bool isRead;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DudaCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      backgroundColor: isRead ? AppColors.surface : AppColors.welcomeCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: DudaText.title(title)),
              DudaTag(label: _categoryLabel(category)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          DudaText.body(body, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          DudaText.caption(date),
        ],
      ),
    );
  }

  static String _categoryLabel(String category) => switch (category) {
        'aula' => 'Aula',
        'feriado' => 'Feriado',
        'reuniao' => 'Reunião',
        'prazo' => 'Prazo',
        'aviso' => 'Aviso',
        'sistema' => 'Sistema',
        _ => category,
      };
}
