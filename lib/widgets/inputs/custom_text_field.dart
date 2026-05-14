import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

/// FIXA custom-styled text field with optional leading icon.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.suffix,
    this.dark = false,
  });

  final String hint;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;

  /// When true, renders the field on a dark navy background (login screen).
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final Color fill =
        dark ? Colors.white.withValues(alpha: 0.08) : AppColors.surface;
    final Color borderColor =
        dark ? Colors.white.withValues(alpha: 0.12) : AppColors.divider;
    final Color textColor = dark ? Colors.white : AppColors.textPrimary;
    final Color hintColor = dark
        ? Colors.white.withValues(alpha: 0.55)
        : AppColors.textSecondary;
    final Color iconColor = dark
        ? Colors.white.withValues(alpha: 0.75)
        : AppColors.textSecondary;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: hintColor,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: fill,
        prefixIcon: icon == null
            ? null
            : Icon(icon, color: iconColor, size: 20),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
