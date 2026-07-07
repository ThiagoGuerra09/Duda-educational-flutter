import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_button.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class DudaErrorState extends StatelessWidget {
  const DudaErrorState({
    super.key,
    this.message = 'Erro ao carregar os dados.',
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: AppSpacing.lg),
            DudaText.body(message, textAlign: TextAlign.center, color: AppColors.textSecondary),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              DudaButton(
                label: 'Tentar novamente',
                onPressed: onRetry,
                isExpanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
