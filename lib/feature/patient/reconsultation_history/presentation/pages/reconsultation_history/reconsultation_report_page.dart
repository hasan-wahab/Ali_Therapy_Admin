import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_assessment_item.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_field.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_footer.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_note_box.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_question_row.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_recovery.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_sample.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_report_section_card.dart';

// ============================================================
// RECONSULTATION REPORT PAGE
// ------------------------------------------------------------
// Opened from History → View Report.
// UI-first sample. No clinic logo.
// ============================================================

class ReconsultationHistoryReportPage extends StatelessWidget {
  const ReconsultationHistoryReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final report = reconsultationReportSample;
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Reconsultation Report'),
      body: AppTabletSafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reconsultation Report',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      report.date,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      report.clinic,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              ReconsultationReportSectionCard(
                title: 'Patient Information',
                child: AppTabletFieldsGrid(
                  phoneColumns: 2,
                  tabletColumns: 4,
                  children: [
                    ReconsultationReportField(
                      label: 'Patient Name',
                      value: report.patientName,
                    ),
                    ReconsultationReportField(
                      label: 'CNIC / ID',
                      value: report.cnic,
                    ),
                    ReconsultationReportField(
                      label: 'Age / Gender',
                      value: report.ageGender,
                    ),
                    ReconsultationReportField(
                      label: 'Consultant',
                      value: report.consultant,
                    ),
                  ],
                ),
              ),

              ReconsultationReportSectionCard(
                title: 'Reconsultation Scenario / Trigger',
                child: ReconsultationReportNoteBox(text: report.scenario),
              ),

              ReconsultationReportSectionCard(
                title: 'Patient Feedback & Compliance',
                child: Column(
                  children: [
                    for (final item in report.questions)
                      ReconsultationReportQuestionRow(item: item),
                  ],
                ),
              ),

              AppTabletFieldsGrid(
                phoneColumns: 1,
                tabletColumns: 2,
                children: [
                  ReconsultationReportSectionCard(
                    title: 'Any Complaint (Optional)',
                    child: ReconsultationReportNoteBox(
                      text: report.complaint,
                      minHeight: 88.h,
                    ),
                  ),
                  ReconsultationReportSectionCard(
                    title: 'How much have you recovered?',
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: ReconsultationReportRecovery(
                        score: report.recoveryScore,
                        maxScore: report.recoveryMax,
                      ),
                    ),
                  ),
                ],
              ),

              ReconsultationReportSectionCard(
                title: 'Reconsultant Internal Assessment',
                child: AppTabletFieldsGrid(
                  phoneColumns: 1,
                  tabletColumns: 3,
                  children: [
                    for (final item in report.assessments)
                      ReconsultationReportAssessmentItem(item: item),
                  ],
                ),
              ),

              SizedBox(height: 4.h),
              ReconsultationReportFooter(
                onBack: () => AppNavigation.back(context),
                onPrint: () => AppSnackbar.info(
                  context,
                  'Print Report coming soon',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
