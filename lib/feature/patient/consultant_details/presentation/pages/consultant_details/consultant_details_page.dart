import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_field.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_list_field.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_muscle_card.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_region_grid.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_section_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_consultant_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';

// ============================================================
// CONSULTANT DETAILS PAGE
// ------------------------------------------------------------
// Consultant Assessment — from Patient Full View extra.
// Pull refresh reloads Full View — AppBar underline loading.
// Empty / missing values show "_".
// ============================================================

class ConsultantDetailsPage extends StatelessWidget {
  const ConsultantDetailsPage({super.key});

  static const Map<String, String> _defaultSpecialTests = {
    'Cervical': '',
    'Shoulder': '',
    'Elbow': '',
    'Wrist': '',
    'Hand': '',
    'Thoracic': '',
    'Lumbar': '',
    'Hip': '',
    'Knee': '',
    'Ankle': '',
  };

  static const Map<String, String> _defaultMmt = {
    'Upper Limb': '',
    'Lower Limb': '',
  };

  Map<String, String> _mergedRegions(
    Map<String, String> defaults,
    Map<String, String> api,
  ) {
    final result = Map<String, String>.from(defaults);
    api.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'Consultant Details',
      builder: (context, detail) {
        return _buildReport(context, detail.consultantDetails);
      },
    );
  }

  Widget _buildReport(
    BuildContext context,
    PatientDetailConsultantEntity consultant,
  ) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    final assessmentId = PatientDetailDisplay.hashedId(consultant.id);
    final visitId = PatientDetailDisplay.hashedId(consultant.visitId);
    final createdAt = PatientDetailDisplay.dateTime(consultant.createdAt);
    final consultantName = PatientDetailDisplay.text(consultant.consultant);

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
                'Consultant Assessment',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Assessment $assessmentId  ·  Visit $visitId',
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
              Text(
                'Consultant: $consultantName',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        ConsultantSectionCard(
          title: 'Clinical Findings & Diagnosis',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConsultantListField(
                label: 'Diagnosis',
                values: consultant.diagnosis,
              ),
              ConsultantField(
                label: 'Note',
                value: PatientDetailDisplay.text(consultant.note),
              ),
            ],
          ),
        ),

        ConsultantSectionCard(
          title: 'Session Settings',
          child: ConsultantField(
            label: 'Prescribed Session Duration',
            value: PatientDetailDisplay.text(
              consultant.prescribedSessionDuration,
            ),
          ),
        ),

        ConsultantSectionCard(
          title: 'Advice',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConsultantListField(
                label: 'Investigations Done',
                values: consultant.investigationsDone,
              ),
              ConsultantField(
                label: 'Other Investigations / Advice',
                value: PatientDetailDisplay.text(
                  consultant.otherInvestigationsAdvice,
                ),
              ),
            ],
          ),
        ),

        ConsultantSectionCard(
          title: 'Special Tests Examination',
          child: ConsultantRegionGrid(
            regions: _mergedRegions(
              _defaultSpecialTests,
              consultant.specialTests,
            ),
          ),
        ),

        ConsultantSectionCard(
          title: 'Manual Muscle Testing (MMT)',
          child: ConsultantRegionGrid(
            regions: _mergedRegions(_defaultMmt, consultant.mmt),
          ),
        ),

        ConsultantSectionCard(
          title: 'Muscle Assessments / Exercises',
          child: consultant.muscles.isEmpty
              ? const ConsultantListField(
                  label: 'Muscles',
                  values: [],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < consultant.muscles.length; i++)
                      ConsultantMuscleCard(
                        initiallyExpanded: i == 0,
                        muscle: PatientDetailDisplay.text(
                          consultant.muscles[i].muscle,
                        ),
                        conditions: consultant.muscles[i].conditions,
                        manualTreatments:
                            consultant.muscles[i].manualTreatments,
                        otherTreatment: PatientDetailDisplay.text(
                          consultant.muscles[i].otherTreatment,
                        ),
                        prescribedExercises:
                            consultant.muscles[i].prescribedExercises,
                        defaultExercises:
                            consultant.muscles[i].defaultExercises,
                      ),
                  ],
                ),
        ),

        ConsultantSectionCard(
          title: 'General Therapeutic Prescription',
          child: AppTabletFieldsGrid(
            phoneColumns: 1,
            tabletColumns: 2,
            children: [
              ConsultantField(
                label: 'Electrotherapy',
                value: PatientDetailDisplay.text(
                  consultant.prescription.electrotherapy,
                ),
              ),
              ConsultantField(
                label: 'Thermo / Cryotherapy',
                value: PatientDetailDisplay.text(
                  consultant.prescription.thermoCryotherapy,
                ),
              ),
              ConsultantField(
                label: 'Anti-Inflammatory Modalities',
                value: PatientDetailDisplay.text(
                  consultant.prescription.antiInflammatory,
                ),
              ),
              ConsultantField(
                label: 'Advanced Techniques',
                value: PatientDetailDisplay.text(
                  consultant.prescription.advancedTechniques,
                ),
              ),
              ConsultantField(
                label: 'Medications',
                value: PatientDetailDisplay.text(
                  consultant.prescription.medications,
                ),
              ),
              ConsultantField(
                label: 'Topicals',
                value: PatientDetailDisplay.text(
                  consultant.prescription.topicals,
                ),
              ),
            ],
          ),
        ),

        ConsultantSectionCard(
          title: 'Selected Packages',
          child: ConsultantListField(
            label: 'Assigned Packages',
            values: consultant.assignedPackages,
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
