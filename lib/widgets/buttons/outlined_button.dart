import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

/// FIXA outlined button — used for secondary actions, e.g. "Continue
/// with Google" or "View Profile".
class FixaOutlinedButton extends StatelessWidget {
  const FixaOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.color = AppColors.dark,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
      foregroundColor: color,
      side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      minimumSize: fullWidth ? const Size.fromHeight(54) : null,
      textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
    );

    return OutlinedButton(
      style: style,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
          ],
          Text(label),
        ],
      ),
    );
  }
}
