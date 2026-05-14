import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_style.dart';
import '../../core/utils/helpers.dart';

/// Mechanic / garage list-card with a circular network photo.
class MechanicCard extends StatelessWidget {
  const MechanicCard({
    super.key,
    required this.mechanic,
    required this.onRequest,
    required this.onViewProfile,
    this.compact = false,
  });

  final Map<String, dynamic> mechanic;
  final VoidCallback onRequest;
  final VoidCallback onViewProfile;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final String name = mechanic['name'] as String;
    final String specialization = mechanic['specialization'] as String;
    final double rating = (mechanic['rating'] as num).toDouble();
    final String distance = mechanic['distance'] as String;
    final String rate = mechanic['rate'] as String;
    final String status = mechanic['status'] as String;
    final String? image = mechanic['image'] as String?;
    final String initials = mechanic['initials'] as String;
    final Color avatarColor = Helpers.colorFromInt(mechanic['color'] as int);

    final Color badgeColor = Helpers.statusColor(status);
    final String badgeLabel = Helpers.statusLabel(status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
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
        children: <Widget>[
          Row(
            children: <Widget>[
              _Avatar(
                image: image,
                fallbackInitials: initials,
                fallbackColor: avatarColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: appStyle(
                              15,
                              AppColors.textPrimary,
                              FontWeight.w600,
                            ),
                          ),
                        ),
                        _Badge(label: badgeLabel, color: badgeColor),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialization,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appStyle(
                        12,
                        AppColors.textSecondary,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _IconLabel(
                icon: Icons.star_rounded,
                color: AppColors.primary,
                label: rating.toStringAsFixed(1),
              ),
              const SizedBox(width: 14),
              _IconLabel(
                icon: IconlyLight.location,
                color: AppColors.textSecondary,
                label: distance,
              ),
              const SizedBox(width: 14),
              _IconLabel(
                icon: Iconsax.wallet_copy,
                color: AppColors.textSecondary,
                label: rate,
              ),
            ],
          ),
          if (!compact) ...<Widget>[
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewProfile,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.dark,
                      side: const BorderSide(color: AppColors.divider),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      textStyle: appStyle(13, AppColors.dark, FontWeight.w600),
                    ),
                    child: const Text('View Profile'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: status == 'busy' ? null : onRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(
                        alpha: 0.4,
                      ),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      textStyle: appStyle(13, Colors.white, FontWeight.w600),
                    ),
                    child: const Text('Request'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.image,
    required this.fallbackInitials,
    required this.fallbackColor,
  });

  final String? image;
  final String fallbackInitials;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: fallbackColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: fallbackColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: image == null || image!.isEmpty
          ? _Initials(text: fallbackInitials, color: fallbackColor)
          : CachedNetworkImage(
              imageUrl: image!,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) =>
                  _Initials(text: fallbackInitials, color: fallbackColor),
              errorWidget: (BuildContext context, String url, Object error) =>
                  _Initials(text: fallbackInitials, color: fallbackColor),
            ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color.withValues(alpha: 0.18),
      child: Text(text, style: appStyle(15, color, FontWeight.w700)),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label, style: appStyle(10, color, FontWeight.w400)),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: appStyle(12, AppColors.textPrimary, FontWeight.w500),
        ),
      ],
    );
  }
}
