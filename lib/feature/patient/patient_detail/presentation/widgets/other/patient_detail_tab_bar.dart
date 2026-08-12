import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab_button.dart';

// ============================================================
// PATIENT DETAIL TAB BAR
// ------------------------------------------------------------
// Equal-width tabs with even space across the row.
// ============================================================

class PatientDetailTabBar extends StatelessWidget {
  const PatientDetailTabBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final PatientDetailTab activeTab;
  final ValueChanged<PatientDetailTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PatientDetailTabButton(
            label: 'Profile',
            icon: Icons.person_outline,
            isActive: activeTab == PatientDetailTab.profile,
            onTap: () => onTabSelected(PatientDetailTab.profile),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: PatientDetailTabButton(
            label: 'Records',
            icon: Icons.description_outlined,
            isActive: activeTab == PatientDetailTab.records,
            onTap: () => onTabSelected(PatientDetailTab.records),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: PatientDetailTabButton(
            label: 'Progress',
            icon: Icons.show_chart_rounded,
            isActive: activeTab == PatientDetailTab.progress,
            onTap: () => onTabSelected(PatientDetailTab.progress),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: PatientDetailTabButton(
            label: 'Survey',
            icon: Icons.assignment_outlined,
            isActive: activeTab == PatientDetailTab.survey,
            onTap: () => onTabSelected(PatientDetailTab.survey),
          ),
        ),
      ],
    );
  }
}
