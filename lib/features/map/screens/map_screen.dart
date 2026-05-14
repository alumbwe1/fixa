import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/helpers.dart';
import '../../../widgets/buttons/outlined_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/loading/custom_loading_indicator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// When null, no mechanic is selected — the bottom sheet is hidden.
  String? _selectedId;

  Map<String, dynamic>? get _selectedMechanic {
    if (_selectedId == null) return null;
    return DummyData.mechanics.firstWhere(
      (Map<String, dynamic> m) => (m['id'] as String) == _selectedId,
      orElse: () => DummyData.mechanics.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom nav is intentionally hidden on the map screen so the
      // map can fill the viewport edge to edge.
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            // Tapping the map background dismisses the bottom sheet.
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _selectedId = null),
                child: _buildMapImage(),
              ),
            ),
            _buildPins(context),
            _buildUserPin(),
            _buildTopBar(context),
            // Only render the bottom sheet when a pin is selected.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> anim) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                );
              },
              child: _selectedMechanic == null
                  ? const SizedBox.shrink()
                  : _buildBottomSheet(context, _selectedMechanic!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapImage() {
    return CachedNetworkImage(
      imageUrl: AppStrings.mapImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (BuildContext context, String url) => const Center(
        child: FixaLoadingIndicator(size: FixaLoadingSize.medium),
      ),
      errorWidget: (BuildContext context, String url, Object error) =>
          Container(
            color: AppColors.background,
            alignment: Alignment.center,
            child: const Icon(
              Icons.map_outlined,
              size: 80,
              color: AppColors.textSecondary,
            ),
          ),
    );
  }

  Widget _buildPins(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: DummyData.mapPins.map((Map<String, dynamic> pin) {
            final String id = pin['id'] as String;
            final String type = pin['type'] as String;
            final double left = (pin['left'] as double) * constraints.maxWidth;
            final double top = (pin['top'] as double) * constraints.maxHeight;
            final bool isSelected = id == _selectedId;
            return Positioned(
              left: left - 22,
              top: top - 22,
              child: GestureDetector(
                onTap: () => setState(() {
                  // Tap same pin twice = deselect (hide sheet).
                  _selectedId = isSelected ? null : id;
                }),
                child: _MapPin(type: type, selected: isSelected),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserPin() {
    return const Align(alignment: Alignment(0.0, 0.05), child: _UserPin());
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: <Widget>[
          _CircleAction(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => context.go('/home'),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  IconlyBold.location,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  AppStrings.location,
                  style: appStyle(12, AppColors.textPrimary, FontWeight.w600),
                ),
              ],
            ),
          ),
          const Spacer(),
          _CircleAction(
            icon: Icons.layers_outlined,
            onTap: () => Helpers.showSnack(context, 'Map layers — coming soon'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, Map<String, dynamic> m) {
    return Align(
      key: ValueKey<String>('sheet-${m['id']}'),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(40),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Drag handle / close affordance
            GestureDetector(
              onTap: () => setState(() => _selectedId = null),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                _SheetAvatar(image: m['image'] as String?),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        m['name'] as String,
                        style: appStyle(
                          15,
                          AppColors.textPrimary,
                          FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        m['specialization'] as String,
                        style: appStyle(
                          12,
                          AppColors.textSecondary,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      (m['rating'] as num).toStringAsFixed(1),
                      style: appStyle(
                        13,
                        AppColors.textPrimary,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                _Metric(
                  icon: IconlyLight.location,
                  label: m['distance'] as String,
                  caption: 'Distance',
                ),
                const SizedBox(width: 10),
                _Metric(
                  icon: Icons.schedule_rounded,
                  label: m['eta'] as String,
                  caption: 'ETA',
                ),
                const SizedBox(width: 10),
                _Metric(
                  icon: Iconsax.wallet_copy,
                  label: m['rate'] as String,
                  caption: 'Rate',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: FixaOutlinedButton(
                    label: AppStrings.viewProfile,
                    onPressed: () => context.push('/mechanic/${m['id']}'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    label: AppStrings.requestNow,
                    onPressed: () => context.push('/request/${m['id']}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SheetAvatar extends StatelessWidget {
  const _SheetAvatar({required this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: image == null
          ? const Icon(Icons.person, color: AppColors.primary)
          : CachedNetworkImage(
              imageUrl: image!,
              fit: BoxFit.cover,
              errorWidget: (BuildContext context, String url, Object error) =>
                  const Icon(Icons.person, color: AppColors.primary),
            ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.type, required this.selected});

  final String type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bool isGarage = type == 'garage';
    final Color color = isGarage ? AppColors.success : AppColors.primary;
    final IconData icon = isGarage
        ? Icons.store_mall_directory_outlined
        : Icons.build_rounded;
    final double size = selected ? 48 : 40;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: selected ? 16 : 8,
            spreadRadius: selected ? 2 : 0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: selected ? 22 : 18),
    );
  }
}

class _UserPin extends StatelessWidget {
  const _UserPin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.6),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.label,
    required this.caption,
  });

  final IconData icon;
  final String label;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: appStyle(13, AppColors.textPrimary, FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              caption,
              style: appStyle(10, AppColors.textSecondary, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
