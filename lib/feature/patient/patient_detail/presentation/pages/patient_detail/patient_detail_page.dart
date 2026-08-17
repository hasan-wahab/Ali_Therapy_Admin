import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_tab_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/profile/patient_detail_profile_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/progress/patient_detail_progress_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/records/patient_detail_records_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/sections/survey/patient_detail_survey_section.dart';

// ============================================================
// PATIENT DETAIL PAGE
// ------------------------------------------------------------
// Tabs switch sections on the same Detail screen.
// ============================================================

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  PatientDetailTab _activeTab = PatientDetailTab.profile;

  Widget _buildSection() {
    switch (_activeTab) {
      case PatientDetailTab.profile:
        return const PatientDetailProfileSection();
      case PatientDetailTab.records:
        return const PatientDetailRecordsSection();
      case PatientDetailTab.progress:
        return const PatientDetailProgressSection();
      case PatientDetailTab.survey:
        return const PatientDetailSurveySection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    final scrollContent = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PatientDetailTabBar(
            activeTab: _activeTab,
            onTabSelected: (tab) {
              setState(() => _activeTab = tab);
            },
          ),
          SizedBox(height: 12.h),
          _buildSection(),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Detail'),
      body: SafeArea(
        child: isTablet
            ? Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppDevice.contentMaxWidth(context),
                  ),
                  child: scrollContent,
                ),
              )
            : scrollContent,
      ),
    );
  }
}
