import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:duda_educational_flutter/core/router/routes.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class DudaRoundIconButton extends StatelessWidget {
  const DudaRoundIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.textOnPrimary.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: AppColors.textOnPrimary, size: 22),
        ),
      ),
    );
  }
}

class DudaHeaderActions {
  static List<Widget> notificationsAndChat(BuildContext context) => [
        DudaRoundIconButton(
          icon: Icons.notifications_outlined,
          onPressed: () => context.push(AppRoutes.notifications),
        ),
        const SizedBox(width: AppSpacing.sm),
        DudaRoundIconButton(
          icon: Icons.chat_bubble_outline,
          onPressed: () => context.push(AppRoutes.chat),
        ),
        const SizedBox(width: AppSpacing.md),
      ];
}

class DudaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DudaAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
  });

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 72 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      title: title == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DudaText.headline(
                  title!,
                  color: subtitle != null ? AppColors.textOnPrimary.withValues(alpha: 0.8) : AppColors.textOnPrimary,
                  textAlign: TextAlign.center,
                ),
                if (subtitle != null)
                  DudaText.caption(
                    subtitle!,
                    color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
    );
  }
}

class DudaSecondaryAppBar extends StatelessWidget {
  const DudaSecondaryAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            ?leading,
            Expanded(child: title ?? const SizedBox.shrink()),
            ...?actions,
          ],
        ),
      ),
    );
  }
}

class DudaFilterBar extends StatelessWidget {
  const DudaFilterBar({
    super.key,
    this.leading,
    this.center,
    this.trailing,
  });

  final Widget? leading;
  final Widget? center;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          ?leading,
          Expanded(child: center ?? const SizedBox.shrink()),
          ?trailing,
        ],
      ),
    );
  }
}

class DudaDropdownChip extends StatelessWidget {
  const DudaDropdownChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.smallAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DudaText.body(label, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary, size: 20),
        ],
      ),
    );
  }
}
