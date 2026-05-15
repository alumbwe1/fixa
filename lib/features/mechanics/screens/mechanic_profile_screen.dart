import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/helpers.dart';
import '../../../widgets/buttons/outlined_button.dart';
import '../../../widgets/buttons/primary_button.dart';

class MechanicProfileScreen extends StatelessWidget {
  const MechanicProfileScreen({super.key, required this.mechanicId});

  final String mechanicId;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> m = DummyData.mechanics.firstWhere(
      (Map<String, dynamic> e) => (e['id'] as String) == mechanicId,
      orElse: () => DummyData.mechanics.first,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHero(context, m),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                _buildIdentity(m),
                const SizedBox(height: 20),
                _buildStatsRow(m),
                const SizedBox(height: 18),
                _Section(
                  title: 'About',
                  child: Text(
                    'Experienced ${m['specialization']} specialist serving '
                    'the Copperbelt region. Reliable, fast and friendly — '
                    'trusted by ${m['jobs']}+ vehicle owners.',
                    style: appStyle(
                      13,
                      AppColors.textSecondary,
                      FontWeight.w400,
                    ).copyWith(height: 1.55),
                  ),
                ),
                const SizedBox(height: 12),
                _Section(
                  title: 'Services & Pricing',
                  child: Column(
                    children: <Widget>[
                      _PriceRow(label: 'Call-out fee', value: 'K50'),
                      _PriceRow(
                        label: 'Hourly rate',
                        value: m['rate'] as String,
                      ),
                      _PriceRow(label: 'Diagnostic', value: 'K80'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _Section(
                  title: 'Specialties',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _specialtyChips(m['specialization'] as String),
                  ),
                ),
                const SizedBox(height: 12),
                _Section(
                  title: 'Recent reviews',
                  child: Column(
                    children: const <Widget>[
                      _Review(
                        name: 'Mwansa C.',
                        rating: 5,
                        text:
                            'Quick response and fixed my alternator in under an hour.',
                      ),
                      SizedBox(height: 10),
                      _Review(
                        name: 'Bwalya M.',
                        rating: 4,
                        text:
                            'Fair pricing and good communication. Will use again.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FixaOutlinedButton(
                        label: 'Message',
                        icon: Icons.chat_bubble_outline_rounded,
                        onPressed: () =>
                            Helpers.showSnack(context, 'Chat — coming soon'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Request Now',
                        onPressed: () => context.push('/request/${m['id']}'),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context, Map<String, dynamic> m) {
    final String? image = m['image'] as String?;

    return SliverAppBar(
      expandedHeight: 280,
      backgroundColor: AppColors.dark,
      foregroundColor: Colors.white,
      pinned: true,
      stretch: true,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Material(
          color: Colors.white.withValues(alpha: 0.9),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.of(context).maybePop(),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Material(
            color: Colors.white.withValues(alpha: 0.9),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Helpers.showSnack(context, 'Added to favourites'),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 18,
                  color: AppColors.error,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (image != null)
              CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                errorWidget: (BuildContext context, String url, Object error) =>
                    Container(color: AppColors.dark),
              )
            else
              Container(color: AppColors.dark),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentity(Map<String, dynamic> m) {
    final Color statusBg = Helpers.statusColor(
      m['status'] as String,
    ).withValues(alpha: 0.12);
    final Color statusFg = Helpers.statusColor(m['status'] as String);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      m['name'] as String,
                      style: appStyle(
                        20,
                        AppColors.textPrimary,
                        FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m['specialization'] as String,
                      style: appStyle(
                        13,
                        AppColors.textSecondary,
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusFg,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      Helpers.statusLabel(m['status'] as String),
                      style: appStyle(12, statusFg, FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Icon(
                IconlyLight.location,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '${m['distance']} • ${m['eta']}',
                style: appStyle(12, AppColors.textSecondary, FontWeight.w500),
              ),
              const Spacer(),
              const Icon(
                Icons.star_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 2),
              Text(
                (m['rating'] as num).toStringAsFixed(1),
                style: appStyle(13, AppColors.textPrimary, FontWeight.w600),
              ),
              const SizedBox(width: 4),
              Text(
                '(${m['jobs']} jobs)',
                style: appStyle(12, AppColors.textSecondary, FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(Map<String, dynamic> m) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            color: AppColors.primary,
            label: (m['rating'] as num).toStringAsFixed(1),
            caption: 'Rating',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle_outline_rounded,
            color: AppColors.success,
            label: '${m['jobs']}',
            caption: 'Jobs done',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.schedule_rounded,
            color: AppColors.dark,
            label: m['eta'] as String,
            caption: 'ETA',
          ),
        ),
      ],
    );
  }

  List<Widget> _specialtyChips(String specialization) {
    // Split the specialization on common separators for nicer visuals.
    final List<String> parts = specialization
        .split(RegExp(r'[&,/]'))
        .map((String s) => s.trim())
        .where((String s) => s.isNotEmpty)
        .toList();
    final List<String> tags = parts.isEmpty ? <String>[specialization] : parts;
    return tags
        .map(
          (String label) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              label,
              style: appStyle(12, AppColors.primary, FontWeight.w600),
            ),
          ),
        )
        .toList();
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: appStyle(15, AppColors.textPrimary, FontWeight.w600),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.caption,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: appStyle(15, AppColors.textPrimary, FontWeight.w700),
          ),
          Text(
            caption,
            style: appStyle(11, AppColors.textSecondary, FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: appStyle(13, AppColors.textSecondary, FontWeight.w400),
            ),
          ),
          Text(
            value,
            style: appStyle(13, AppColors.textPrimary, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({required this.name, required this.rating, required this.text});

  final String name;
  final int rating;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                name,
                style: appStyle(13, AppColors.textPrimary, FontWeight.w600),
              ),
              const Spacer(),
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: i < rating ? AppColors.primary : AppColors.divider,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: appStyle(
              12,
              AppColors.textSecondary,
              FontWeight.w400,
            ).copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }
}
