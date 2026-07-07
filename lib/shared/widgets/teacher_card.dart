import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_avatar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_card.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    required this.name,
    required this.initials,
    required this.welcomeMessage,
    super.key,
    this.department,
    this.campus,
  });

  final String name;
  final String initials;
  final String welcomeMessage;
  final String? department;
  final String? campus;

  @override
  Widget build(BuildContext context) {
    return DudaCard(
      backgroundColor: AppColors.welcomeCard,
      child: Row(
        children: [
          DudaAvatar(initials: initials, size: 56),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DudaText.label('OLÁ, $name'.toUpperCase()),
                const SizedBox(height: AppSpacing.xs),
                DudaText.title(welcomeMessage),
                if (department != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  DudaText.caption('$department • $campus'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
