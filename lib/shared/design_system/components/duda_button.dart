import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

enum DudaButtonVariant { primary, secondary, outlined, text }

class DudaButton extends StatelessWidget {
  const DudaButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = DudaButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final DudaButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.textOnPrimary,
            ),
          )
        : Row(
            mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: _foregroundColor(enabled)),
                const SizedBox(width: AppSpacing.sm),
              ],
              DudaText.button(
                label.toUpperCase(),
                color: _foregroundColor(enabled),
              ),
            ],
          );

    final button = switch (variant) {
      DudaButtonVariant.primary => ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
            foregroundColor: AppColors.textOnPrimary,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.lg,
              horizontal: AppSpacing.xl,
            ),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
            elevation: 0,
          ),
          child: child,
        ),
      DudaButtonVariant.secondary => ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            disabledBackgroundColor: AppColors.secondary.withValues(alpha: 0.4),
            foregroundColor: AppColors.textOnPrimary,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.lg,
              horizontal: AppSpacing.xl,
            ),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
            elevation: 0,
          ),
          child: child,
        ),
      DudaButtonVariant.outlined => OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.lg,
              horizontal: AppSpacing.xl,
            ),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
          ),
          child: child,
        ),
      DudaButtonVariant.text => TextButton(
          onPressed: enabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.lg,
            ),
          ),
          child: child,
        ),
    };

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  Color _foregroundColor(bool enabled) {
    if (!enabled) return AppColors.textOnPrimary.withValues(alpha: 0.6);
    return switch (variant) {
      DudaButtonVariant.primary || DudaButtonVariant.secondary => AppColors.textOnPrimary,
      DudaButtonVariant.outlined || DudaButtonVariant.text => AppColors.primary,
    };
  }
}
