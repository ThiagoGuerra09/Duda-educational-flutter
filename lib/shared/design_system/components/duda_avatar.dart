import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class DudaAvatar extends StatelessWidget {
  const DudaAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 44,
    this.isOnline = false,
    this.heroTag,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isOnline;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.welcomeCard,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? DudaText.title(
              initials ?? '?',
              color: AppColors.primary,
            )
          : null,
    );

    final content = Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: content);
    }
    return content;
  }
}

class DudaAvatarRow extends StatelessWidget {
  const DudaAvatarRow({
    required this.name,
    super.key,
    this.subtitle,
    this.initials,
    this.imageUrl,
    this.heroTag,
  });

  final String name;
  final String? subtitle;
  final String? initials;
  final String? imageUrl;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DudaAvatar(
          initials: initials ?? name.characters.first,
          imageUrl: imageUrl,
          heroTag: heroTag,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DudaText.title(name),
              if (subtitle != null) DudaText.caption(subtitle!),
            ],
          ),
        ),
      ],
    );
  }
}
