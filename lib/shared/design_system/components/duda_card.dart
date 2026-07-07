import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/shadows.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class DudaCard extends StatelessWidget {
  const DudaCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.accentColor,
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? accentColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final content = DudaCardContent(
      padding: padding,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
      borderRadius: borderRadius,
      child: child,
    );

    if (onTap == null) {
      return Padding(padding: margin ?? EdgeInsets.zero, child: content);
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? AppRadius.mediumAll,
          child: content,
        ),
      ),
    );
  }
}

class DudaCardContent extends StatelessWidget {
  const DudaCardContent({
    required this.child,
    super.key,
    this.padding,
    this.backgroundColor,
    this.accentColor,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? accentColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: borderRadius ?? AppRadius.mediumAll,
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.border),
      ),
      // IntrinsicHeight limita a altura do Row ao conteúdo: com
      // CrossAxisAlignment.stretch dentro de um ListView (altura infinita),
      // o layout quebraria com "BoxConstraints forces an infinite height".
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (accentColor != null)
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: (borderRadius ?? AppRadius.mediumAll).topLeft,
                    bottomLeft:
                        (borderRadius ?? AppRadius.mediumAll).bottomLeft,
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
