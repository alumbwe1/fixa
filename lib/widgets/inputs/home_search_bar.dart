import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_style.dart';

/// Dedicated home-screen search bar.
///
/// Distinct from [CustomTextField] — this is a single-line, neutral-coloured
/// pill input with a leading search icon and an optional trailing filter
/// button. It uses a soft grey background (`AppColors.background`) so it
/// stands apart from the white service cards beneath it.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.hint = 'Search mechanics, garages...',
    this.controller,
    this.onChanged,
    this.onFilterTap,
    this.onSubmitted,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: <Widget>[
          Icon(IconlyLight.search, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              cursorColor: AppColors.primary,

              style: appStyle(14, AppColors.textPrimary, FontWeight.w500),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.background,
                hintText: hint,
                hintStyle: appStyle(
                  14,
                  Colors.grey.shade600,
                  FontWeight.w400,
                ).copyWith(letterSpacing: -0.05),
              ),
            ),
          ),
          if (onFilterTap != null) ...<Widget>[
            const SizedBox(width: 8),
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onFilterTap,
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(
                    IconlyLight.filter,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
