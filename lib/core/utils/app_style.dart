import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Quick Poppins text style helper — keeps screens terse.
///
/// Usage:
/// ```dart
/// Text('Hello', style: appStyle(14, AppColors.textPrimary, FontWeight.w500));
/// ```
TextStyle appStyle(double size, Color color, FontWeight weight) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: weight,
  );
}

/// Pre-built styles for the FIXA design system.
class AppText {
  AppText._();

  static TextStyle display = appStyle(
    28,
    AppColors.textPrimary,
    FontWeight.w700,
  );
  static TextStyle heading = appStyle(
    20,
    AppColors.textPrimary,
    FontWeight.w600,
  );
  static TextStyle subheading = appStyle(
    16,
    AppColors.textPrimary,
    FontWeight.w600,
  );
  static TextStyle body = appStyle(
    14,
    AppColors.textPrimary,
    FontWeight.w400,
  );
  static TextStyle bodyMuted = appStyle(
    14,
    AppColors.textSecondary,
    FontWeight.w400,
  );
  static TextStyle caption = appStyle(
    12,
    AppColors.textSecondary,
    FontWeight.w400,
  );
  static TextStyle button = appStyle(
    15,
    Colors.white,
    FontWeight.w600,
  );
}
