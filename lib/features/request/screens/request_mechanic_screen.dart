import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dummy_data.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/common/app_bar.dart';
import '../../../widgets/inputs/custom_text_field.dart';

class RequestMechanicScreen extends StatefulWidget {
  const RequestMechanicScreen({super.key, required this.mechanicId});

  final String mechanicId;

  @override
  State<RequestMechanicScreen> createState() => _RequestMechanicScreenState();
}

class _RequestMechanicScreenState extends State<RequestMechanicScreen> {
  int _selectedIssue = 0;
  String _urgency = AppStrings.today;
  bool _submitting = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _mechanic => DummyData.mechanics.firstWhere(
        (Map<String, dynamic> m) =>
            (m['id'] as String) == widget.mechanicId,
        orElse: () => DummyData.mechanics.first,
      );

  Future<void> _submit() async {
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _submitting = false);
    await _showSuccessDialog();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.success,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  AppStrings.mechanicOnTheWay,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.requestSentMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: 'Back to Home',
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/home');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FixaAppBar(title: AppStrings.requestTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: <Widget>[
          _buildMechanicHeader(),
          const SizedBox(height: 20),
          _sectionLabel(AppStrings.issueType),
          const SizedBox(height: 10),
          _buildIssueGrid(),
          const SizedBox(height: 20),
          _sectionLabel(AppStrings.describeIssue),
          const SizedBox(height: 10),
          CustomTextField(
            hint: AppStrings.describeHint,
            controller: _descriptionController,
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          _sectionLabel(AppStrings.urgency),
          const SizedBox(height: 10),
          _buildUrgencyRow(),
          const SizedBox(height: 20),
          _sectionLabel(AppStrings.costEstimate),
          const SizedBox(height: 10),
          _buildEstimateCard(),
          const SizedBox(height: 24),
          PrimaryButton(
            label: AppStrings.confirmRequest,
            onPressed: _submit,
            isLoading: _submitting,
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'By confirming you agree to FIXA terms',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildMechanicHeader() {
    final Map<String, dynamic> m = _mechanic;
    final Color accent = Color(m['color'] as int);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: accent.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              m['initials'] as String,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  m['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  m['specialization'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      (m['rating'] as num).toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${m['distance']} • ${m['eta']}',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: DummyData.issueTypes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> issue = DummyData.issueTypes[index];
        final bool selected = _selectedIssue == index;
        return Material(
          color: selected ? AppColors.dark : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _selectedIssue = index),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? AppColors.dark : AppColors.divider,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    _iconForIssue(index),
                    color:
                        selected ? AppColors.primary : AppColors.textPrimary,
                    size: 26,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    issue['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color:
                          selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _iconForIssue(int index) {
    const List<IconData> icons = <IconData>[
      Icons.build_rounded,
      Icons.battery_alert_rounded,
      Icons.tire_repair_rounded,
      Icons.thermostat_rounded,
      Icons.disc_full_rounded,
      Icons.help_outline_rounded,
    ];
    return icons[index];
  }

  Widget _buildUrgencyRow() {
    return Row(
      children: DummyData.urgencyOptions.map((String option) {
        final bool selected = _urgency == option;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: selected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => setState(() => _urgency = option),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.divider,
                    ),
                  ),
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEstimateCard() {
    final String rate = _mechanic['rate'] as String;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: <Widget>[
          _row(label: AppStrings.callOutFee, value: 'K50'),
          const SizedBox(height: 8),
          _row(label: AppStrings.hourlyRate, value: rate),
          const Divider(height: 22),
          _row(
            label: AppStrings.estimatedTotal,
            value: 'K200 - K350',
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _row({
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: highlight ? 14 : 13,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
              color:
                  highlight ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: highlight ? 16 : 14,
            fontWeight: FontWeight.w700,
            color: highlight ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

