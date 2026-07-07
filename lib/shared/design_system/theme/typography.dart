import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';

abstract final class AppTypography {
  static TextStyle get _base => GoogleFonts.inter();

  static TextStyle headline({Color? color}) => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle title({Color? color}) => _base.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle body({Color? color}) => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle label({Color? color}) => _base.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: color ?? AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle caption({Color? color}) => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle button({Color? color}) => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: color ?? AppColors.textOnPrimary,
        height: 1.2,
      );
}
