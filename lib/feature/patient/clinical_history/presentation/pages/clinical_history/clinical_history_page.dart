import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_field.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_list_field.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_section_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_clinical_history_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';

// ============================================================
// CLINICAL HISTORY PAGE
// ------------------------------------------------------------
// History Taking Report — from Patient Full View extra.
// Pull refresh reloads Full View — AppBar underline loading.
// Empty / missing values show "_".
// ============================================================

class ClinicalHistoryPage extends StatelessWidget {
  const ClinicalHistoryPage({super.key});

  bool _hasHistory(PatientDetailClinicalHistoryEntity history) {
    return PatientDetailDisplay.text(history.id) != PatientDetailDisplay.empty ||
        PatientDetailDisplay.text(history.patientName) !=
            PatientDetailDisplay.empty;
  }

  String _vas(PatientDetailClinicalHistoryEntity history) {
    if (!_hasHistory(history)) return PatientDetailDisplay.empty;
    return '${history.painDetails.intensityVas} / 10';
  }

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Clinical History',
      builder: (context, detail) {
        return _buildReport(context, detail.clinicalHistory);
      },
    );
  }

  Widget _buildReport(
    BuildContext context,
    PatientDetailClinicalHistoryEntity history,
  ) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    final visitId = PatientDetailDisplay.hashedId(history.visitId);
    final name = PatientDetailDisplay.titled(history.patientName);
    final age = PatientDetailDisplay.ageYears(history.age);
    final createdAt = PatientDetailDisplay.dateTime(history.createdAt);

    final reportContent = Column(
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
                'History Taking Report',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Visit $visitId  ·  $name  ·  $age',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                ),
              ),
              Text(
                createdAt,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Patient Information',
          child: AppTabletFieldsGrid(
            phoneColumns: 1,
            tabletColumns: 2,
            children: [
              ClinicalHistoryField(label: 'Name', value: name),
              ClinicalHistoryField(label: 'Age', value: age),
              ClinicalHistoryField(
                label: 'Occupation',
                value: PatientDetailDisplay.titled(history.occupation),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Pain Location',
          child: ClinicalHistoryListField(
            label: 'Locations',
            values: history.painLocations,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Region Involved',
          child: Column(
            children: [
              ClinicalHistoryListField(
                label: 'Region',
                values: history.region.items,
              ),
              ClinicalHistoryListField(
                label: 'Side Affected',
                values: history.region.sideAffected,
              ),
              ClinicalHistoryField(
                label: 'Deviation',
                value: PatientDetailDisplay.text(history.region.deviation),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Chief Complaint',
          child: Column(
            children: [
              ClinicalHistoryListField(
                label: 'Complaints',
                values: history.chiefComplaint.items,
              ),
              ClinicalHistoryListField(
                label: 'Side Affected',
                values: history.chiefComplaint.sideAffected,
              ),
              ClinicalHistoryField(
                label: 'Deviation',
                value: PatientDetailDisplay.text(
                  history.chiefComplaint.deviation,
                ),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Pain Details',
          child: Column(
            children: [
              ClinicalHistoryField(
                label: 'Intensity (VAS)',
                value: _vas(history),
              ),
              ClinicalHistoryListField(
                label: 'Type of Pain',
                values: history.painDetails.typeOfPain,
              ),
              ClinicalHistoryField(
                label: 'Pain Pattern',
                value: PatientDetailDisplay.text(
                  history.painDetails.painPattern,
                ),
              ),
              ClinicalHistoryListField(
                label: 'Pain Timing',
                values: history.painDetails.painTiming,
              ),
              ClinicalHistoryField(
                label: 'Duration',
                value: PatientDetailDisplay.text(history.painDetails.duration),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Radiating Pain',
          child: Column(
            children: [
              ClinicalHistoryField(
                label: 'Status',
                value: PatientDetailDisplay.text(history.radiatingPain.status),
              ),
              ClinicalHistoryListField(
                label: 'Radiation Path',
                values: history.radiatingPain.radiationPath,
              ),
              ClinicalHistoryField(
                label: 'Radiation Side',
                value: PatientDetailDisplay.text(
                  history.radiatingPain.radiationSide,
                ),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Associated Symptoms',
          child: ClinicalHistoryListField(
            label: 'Symptoms',
            values: history.associatedSymptoms,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Movement-Related Pain',
          child: ClinicalHistoryListField(
            label: 'Movements',
            values: history.movementRelatedPain,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Onset & Cause',
          child: Column(
            children: [
              ClinicalHistoryField(
                label: 'How pain started',
                value: PatientDetailDisplay.text(
                  history.onsetCause.howPainStarted,
                ),
              ),
              ClinicalHistoryListField(
                label: 'Possible Cause',
                values: history.onsetCause.possibleCause,
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Aggravating Factors',
          child: ClinicalHistoryListField(
            label: 'Factors',
            values: history.aggravatingFactors,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Relieving Factors',
          child: ClinicalHistoryListField(
            label: 'Factors',
            values: history.relievingFactors,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Functional Limitations (ADL)',
          child: ClinicalHistoryListField(
            label: 'Limited Activities',
            values: history.functionalLimitations,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Gait & Movement Analysis',
          child: ClinicalHistoryField(
            label: 'Analysis',
            value: PatientDetailDisplay.text(history.gaitAnalysis),
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Past Medical History & Treatment',
          child: Column(
            children: [
              ClinicalHistoryListField(
                label: 'Medical History',
                values: history.pastHistory.medicalHistory,
              ),
              ClinicalHistoryListField(
                label: 'History Details',
                values: history.pastHistory.historyDetails,
              ),
              ClinicalHistoryField(
                label: 'Surgical History',
                value: PatientDetailDisplay.text(
                  history.pastHistory.surgicalHistory,
                ),
              ),
              ClinicalHistoryListField(
                label: 'Previous Treatments',
                values: history.pastHistory.previousTreatments,
              ),
              ClinicalHistoryField(
                label: 'Physiotherapy Response',
                value: PatientDetailDisplay.text(
                  history.pastHistory.physiotherapyResponse,
                ),
              ),
            ],
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Investigations & Reports',
          child: ClinicalHistoryListField(
            label: 'Investigations Done',
            values: history.investigations,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Red Flags',
          child: ClinicalHistoryListField(
            label: 'Flags',
            values: history.redFlags,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Face: Onset & Course',
          child: ClinicalHistoryListField(
            label: 'Details',
            values: history.faceOnset,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Face: Eye Involvement',
          child: ClinicalHistoryListField(
            label: 'Details',
            values: history.faceEye,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Speech, Eating & Drinking',
          child: ClinicalHistoryListField(
            label: 'Assessment',
            values: history.speechEatingDrinking,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Face-Specific Pain',
          child: ClinicalHistoryListField(
            label: 'Details',
            values: history.facePain,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'Household Work',
          child: ClinicalHistoryListField(
            label: 'Tasks',
            values: history.householdWork,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'For Women Only',
          child: ClinicalHistoryListField(
            label: 'Details',
            values: history.womenOnly,
          ),
        ),

        ClinicalHistorySectionCard(
          title: 'For Men Only',
          child: ClinicalHistoryListField(
            label: 'Details',
            values: history.menOnly,
          ),
        ),
      ],
    );

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
      child: reportContent,
    );
  }
}
