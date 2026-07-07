import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/typography.dart';

enum DudaTextVariant { headline, title, body, label, caption, button }

class DudaText extends StatelessWidget {
  const DudaText(
    this.data, {
    super.key,
    this.variant = DudaTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  const DudaText.headline(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.headline;

  const DudaText.title(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.title;

  const DudaText.body(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.body;

  const DudaText.label(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.label;

  const DudaText.caption(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.caption;

  const DudaText.button(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : variant = DudaTextVariant.button;

  final String data;
  final DudaTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final style = switch (variant) {
      DudaTextVariant.headline => AppTypography.headline(color: color),
      DudaTextVariant.title => AppTypography.title(color: color),
      DudaTextVariant.body => AppTypography.body(color: color),
      DudaTextVariant.label => AppTypography.label(color: color),
      DudaTextVariant.caption => AppTypography.caption(color: color),
      DudaTextVariant.button => AppTypography.button(color: color),
    };

    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
