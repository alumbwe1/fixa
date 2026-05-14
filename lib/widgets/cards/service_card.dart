import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_style.dart';

/// Service tile used on the home screen — uses an image asset
/// instead of a Material icon.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.asset,
    required this.color,
    this.isHighlighted = false,
    required this.onTap,
  });

  final String title;

  /// Path to an asset image (e.g. `assets/gear.png`).
  final String asset;

  /// Tinted background colour of the icon container.
  final Color color;

  final bool isHighlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isHighlighted ? AppColors.primary : AppColors.divider,
              width: isHighlighted ? 1.6 : 1,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.asset(
                  asset,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (BuildContext context, Object error, StackTrace? stack) {
                    return const Icon(
                      Icons.build_outlined,
                      color: AppColors.primary,
                      size: 22,
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: appStyle(14, AppColors.textPrimary, FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                isHighlighted ? 'Recommended' : 'Tap to open',
                style: appStyle(
                  12,
                  isHighlighted ? AppColors.primary : AppColors.textSecondary,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
