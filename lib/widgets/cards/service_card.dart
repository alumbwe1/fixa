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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isHighlighted ? AppColors.primary : AppColors.divider,
            width: isHighlighted ? 0.5 : 0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              asset,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stack) {
                    return const Icon(
                      Icons.build_outlined,
                      color: AppColors.primary,
                      size: 22,
                    );
                  },
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: appStyle(14, AppColors.textPrimary, FontWeight.w700),
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
    );
  }
}
