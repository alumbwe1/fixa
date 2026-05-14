import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Small utility helpers shared across the app.
class Helpers {
  Helpers._();

  /// Show a styled snackbar.
  static void showSnack(BuildContext context, String message) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.dark,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Convert an int color code (used in dummy data) into a [Color].
  static Color colorFromInt(int value) => Color(value);

  /// Map a status string to a friendly badge color.
  static Color statusColor(String status) {
    switch (status) {
      case 'available':
        return AppColors.success;
      case 'busy':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  /// Get capitalised label for a status.
  static String statusLabel(String status) {
    if (status.isEmpty) return '';
    return status[0].toUpperCase() + status.substring(1);
  }
}
