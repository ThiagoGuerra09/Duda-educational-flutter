import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/shadows.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class DudaContainer extends StatelessWidget {
  const DudaContainer({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.width,
    this.height,
    this.boxShadow,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: borderRadius ?? AppRadius.mediumAll,
        border: border,
        boxShadow: boxShadow ?? AppShadows.card,
      ),
      child: child,
    );
  }
}
