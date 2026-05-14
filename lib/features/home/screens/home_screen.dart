import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/utils/app_style.dart';
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
    final List<Map<String, dynamic>> nearby =
        DummyData.mechanics.take(2).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const FixaBottomNav(currentIndex: 0),
      body: FadeTransition(
        opacity: _slideController,
        child: SlideTransition(
          position: _slide,
          child: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  sliver: SliverToBoxAdapter(child: _buildHeader(context)),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  sliver: SliverToBoxAdapter(child: _buildSearchBar()),
                ),
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
                            textStyle: appStyle(
                              13,
                              AppColors.primary,
                              FontWeight.w600,
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
                            onRequest: () =>
                                context.push('/request/${m['id']}'),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello there 👋',
                style:
                    appStyle(12, AppColors.textSecondary, FontWeight.w400),
              ),
              const SizedBox(height: 2),
              Text(
                AppStrings.greeting,
                style: appStyle(20, AppColors.textPrimary, FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const _LocationChip(),
            ],
          ),
        ),
        const _Avatar(),
      ],
    );
  }

  Widget _buildSearchBar() {
    // Independent neutral-coloured search bar — matches the surface tone
    // of the service cards.
    return CustomTextField(
      hint: AppStrings.searchHint,
      icon: Icons.search_rounded,
      textInputAction: TextInputAction.search,
      onChanged: (_) {},
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
        if (trailing != null) trailing,
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
        return ServiceCard(
          title: service['title'] as String,
          asset: service['asset'] as String,
          color: Color(service['bgColor'] as int),
          isHighlighted: service['highlighted'] as bool,
          onTap: () => _handleService(service['key'] as String),
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        'A',
        style: appStyle(18, AppColors.primary, FontWeight.w700),
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.place_rounded,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            AppStrings.location,
            style: appStyle(12, AppColors.textPrimary, FontWeight.w500),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}
