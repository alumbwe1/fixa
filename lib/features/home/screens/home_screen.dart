import 'package:fixa/core/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/utils/helpers.dart';
import '../../../widgets/cards/mechanic_card.dart';
import '../../../widgets/cards/service_card.dart';
import '../../../widgets/common/bottom_nav.dart';
import '../../../widgets/inputs/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _handleService(String key) {
    switch (key) {
      case 'mechanic':
        context.push('/mechanics');
        break;
      case 'garage':
        context.push('/mechanics?filter=Garages');
        break;
      case 'towing':
        context.push('/mechanics?filter=Towing');
        break;
      case 'book':
        Helpers.showSnack(context, 'Service booking — coming soon');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nearby = DummyData.mechanics
        .take(2)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const FixaBottomNav(currentIndex: 0),
      body: FadeTransition(
        opacity: _slideController,
        child: SlideTransition(
          position: _slide,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    _sectionHeader(AppStrings.services),
                    const SizedBox(height: 12),
                    _buildServicesGrid(),
                    const SizedBox(height: 24),
                    _sectionHeader(
                      AppStrings.nearbyMechanics,
                      trailing: TextButton(
                        onPressed: () => context.push('/mechanics'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text(AppStrings.seeAll),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...nearby.map((Map<String, dynamic> m) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: MechanicCard(
                          mechanic: m,
                          onRequest: () => context.push('/request/${m['id']}'),
                          onViewProfile: () =>
                              context.push('/mechanic/${m['id']}'),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello there 👋',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.greeting,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                _Avatar(),
              ],
            ),
            const SizedBox(height: 16),
            _LocationChip(),
            const SizedBox(height: 16),
            CustomTextField(
              hint: AppStrings.searchHint,
              icon: Icons.search_rounded,
              dark: true,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {Widget? trailing}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: appStyle(16, AppColors.textPrimary, FontWeight.w600),
          ),
        ),
        ?trailing,
      ],
    );
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: DummyData.services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> service = DummyData.services[index];
        final IconData icon = _iconForKey(service['key'] as String);
        return ServiceCard(
          title: service['title'] as String,
          icon: icon,
          color: Color(service['bgColor'] as int),
          iconColor: Color(service['iconColor'] as int),
          isHighlighted: service['highlighted'] as bool,
          onTap: () => _handleService(service['key'] as String),
        );
      },
    );
  }

  IconData _iconForKey(String key) {
    switch (key) {
      case 'mechanic':
        return Icons.build_outlined;
      case 'garage':
        return Icons.store_mall_directory_outlined;
      case 'towing':
        return Icons.local_shipping_outlined;
      case 'book':
        return Icons.event_note_outlined;
      default:
        return Icons.build_outlined;
    }
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        'A',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.place_rounded, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            AppStrings.location,
            style: appStyle(12, Colors.white, FontWeight.w500),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}
