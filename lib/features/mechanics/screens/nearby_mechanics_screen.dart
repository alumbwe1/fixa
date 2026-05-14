import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../widgets/cards/mechanic_card.dart';
import '../../../widgets/common/app_bar.dart';
import '../../../widgets/inputs/custom_text_field.dart';

class NearbyMechanicsScreen extends StatefulWidget {
  const NearbyMechanicsScreen({super.key, this.initialFilter});

  final String? initialFilter;

  @override
  State<NearbyMechanicsScreen> createState() => _NearbyMechanicsScreenState();
}

class _NearbyMechanicsScreenState extends State<NearbyMechanicsScreen> {
  late String _filter;
  bool _loading = true;
  String _query = '';

  static const List<String> _filters = <String>[
    AppStrings.filterAll,
    AppStrings.filterAvailable,
    AppStrings.filterGarages,
    AppStrings.filterTowing,
  ];

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter ?? AppStrings.filterAll;
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  List<Map<String, dynamic>> get _filtered {
    Iterable<Map<String, dynamic>> list = DummyData.mechanics;
    switch (_filter) {
      case AppStrings.filterAvailable:
        list = list.where(
          (Map<String, dynamic> m) => (m['status'] as String) == 'available',
        );
        break;
      case AppStrings.filterGarages:
        list = list.where(
          (Map<String, dynamic> m) => (m['type'] as String) == 'garage',
        );
        break;
      case AppStrings.filterTowing:
        list = list.where(
          (Map<String, dynamic> m) => (m['type'] as String) == 'towing',
        );
        break;
    }
    if (_query.isNotEmpty) {
      final String q = _query.toLowerCase();
      list = list.where((Map<String, dynamic> m) {
        return (m['name'] as String).toLowerCase().contains(q) ||
            (m['specialization'] as String).toLowerCase().contains(q);
      });
    }
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FixaAppBar(title: AppStrings.mechanicsTitle),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: CustomTextField(
              hint: AppStrings.searchHint,
              icon: Icons.search_rounded,
              onChanged: (String v) => setState(() => _query = v),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (BuildContext context, int index) {
                final String f = _filters[index];
                final bool active = _filter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: active,
                  onSelected: (_) => setState(() => _filter = f),
                  backgroundColor: AppColors.surface,
                  selectedColor: AppColors.dark,
                  side: BorderSide(
                    color: active ? AppColors.dark : AppColors.divider,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: active ? Colors.white : AppColors.textPrimary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _loading
                ? _buildShimmerList()
                : _filtered.isEmpty
                ? _buildEmpty()
                : _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    final List<Map<String, dynamic>> items = _filtered;
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> m = items[index];
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 250 + (index * 80)),
          curve: Curves.easeOut,
          builder: (BuildContext context, double value, Widget? child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 16),
                child: child,
              ),
            );
          },
          child: MechanicCard(
            mechanic: m,
            onRequest: () => context.push('/request/${m['id']}'),
            onViewProfile: () => context.push('/mechanic/${m['id']}'),
          ),
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            height: 152,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.search_off_rounded,
            size: 56,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 12),
          Text(
            'No mechanics match this filter',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
