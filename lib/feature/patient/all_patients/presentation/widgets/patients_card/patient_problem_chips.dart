import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_problem_chip.dart';

// ============================================================
// PATIENT PROBLEM CHIPS
// ------------------------------------------------------------
// Shows a few chips first. Tap "+N more" to expand all.
// ============================================================

class PatientProblemChips extends StatefulWidget {
  const PatientProblemChips({
    super.key,
    required this.problems,
    this.collapsedCount = 2,
  });

  final String problems;

  /// How many chips to show before "+N more".
  final int collapsedCount;

  @override
  State<PatientProblemChips> createState() => _PatientProblemChipsState();
}

class _PatientProblemChipsState extends State<PatientProblemChips> {
  bool _expanded = false;

  List<String> get _chips {
    if (widget.problems.trim().isEmpty ||
        widget.problems.toLowerCase() == 'no record' ||
        widget.problems.toLowerCase() == 'n/a') {
      return const [];
    }
    return widget.problems
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final chips = _chips;

    if (chips.isEmpty) {
      return Text(
        'No record',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final hasMore = chips.length > widget.collapsedCount;
    final visibleChips =
        _expanded || !hasMore ? chips : chips.take(widget.collapsedCount).toList();
    final hiddenCount = chips.length - widget.collapsedCount;

    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final chip in visibleChips) PatientProblemChip(label: chip),
        if (hasMore && !_expanded)
          PatientProblemChip(
            label: '+$hiddenCount more',
            onTap: () => setState(() => _expanded = true),
          ),
        if (hasMore && _expanded)
          GestureDetector(
            onTap: () => setState(() => _expanded = false),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Text(
                'Show less',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
