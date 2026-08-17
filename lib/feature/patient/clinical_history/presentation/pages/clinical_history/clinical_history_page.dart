import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_field.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_list_field.dart';
import 'package:ali_therapy_admin/feature/patient/clinical_history/presentation/widgets/other/clinical_history_section_card.dart';

// ============================================================
// CLINICAL HISTORY PAGE
// ------------------------------------------------------------
// History Taking Report — mobile layout, all API fields.
// Uses SingleChildScrollView for the full report layout.
// ============================================================

class ClinicalHistoryPage extends StatelessWidget {
  const ClinicalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 16.w;

    final reportContent = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top summary
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
                      'Visit #5611  ·  Iqra Javed  ·  24 years',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      '15 Jul 2026, 12:12 PM',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Patient Information',
                child: AppTabletFieldsGrid(
                  phoneColumns: 1,
                  tabletColumns: 2,
                  children: [
                    ClinicalHistoryField(label: 'Name', value: 'Iqra Javed'),
                    ClinicalHistoryField(label: 'Age', value: '24 years'),
                    ClinicalHistoryField(label: 'Occupation', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Pain Location',
                child: ClinicalHistoryListField(
                  label: 'Locations',
                  values: ['Knee Joint'],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Region Involved',
                child: Column(
                  children: [
                    ClinicalHistoryListField(
                      label: 'Region',
                      values: [
                        'Back thigh (Hamstrings)',
                        'Front thigh (Quadriceps)',
                        'Knee',
                      ],
                    ),
                    ClinicalHistoryListField(
                      label: 'Side Affected',
                      values: ['Right'],
                    ),
                    ClinicalHistoryField(label: 'Deviation', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Chief Complaint',
                child: Column(
                  children: [
                    ClinicalHistoryListField(
                      label: 'Complaints',
                      values: ['Pain', 'Swelling', 'Weakness', 'Tightness'],
                    ),
                    ClinicalHistoryListField(label: 'Side Affected', values: []),
                    ClinicalHistoryField(label: 'Deviation', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Pain Details',
                child: Column(
                  children: [
                    ClinicalHistoryField(
                      label: 'Intensity (VAS)',
                      value: '4 / 10',
                    ),
                    ClinicalHistoryListField(
                      label: 'Type of Pain',
                      values: ['Dull'],
                    ),
                    ClinicalHistoryField(
                      label: 'Pain Pattern',
                      value: 'intermittent',
                    ),
                    ClinicalHistoryListField(label: 'Pain Timing', values: []),
                    ClinicalHistoryField(
                      label: 'Duration',
                      value: 'knee: 8 months',
                    ),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Radiating Pain',
                child: Column(
                  children: [
                    ClinicalHistoryField(label: 'Status', value: 'no'),
                    ClinicalHistoryListField(label: 'Radiation Path', values: []),
                    ClinicalHistoryField(label: 'Radiation Side', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Associated Symptoms',
                child: ClinicalHistoryListField(label: 'Symptoms', values: []),
              ),

              const ClinicalHistorySectionCard(
                title: 'Movement-Related Pain',
                child: ClinicalHistoryListField(
                  label: 'Movements',
                  values: [
                    'Back thigh (Hamstrings): Stretching',
                    'Front thigh (Quadriceps): Standing up',
                    'Knee: Bending',
                    'Squatting',
                    'Stairs',
                    'Walking',
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Onset & Cause',
                child: Column(
                  children: [
                    ClinicalHistoryField(
                      label: 'How pain started',
                      value: 'gradual',
                    ),
                    ClinicalHistoryListField(
                      label: 'Possible Cause',
                      values: ['Trauma / fall'],
                    ),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Aggravating Factors',
                child: ClinicalHistoryListField(
                  label: 'Factors',
                  values: [
                    'knee: Stairs',
                    'Standing long',
                    'Work activities',
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Relieving Factors',
                child: ClinicalHistoryListField(
                  label: 'Factors',
                  values: [
                    'knee: Rest',
                    'Brace / support',
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Functional Limitations (ADL)',
                child: ClinicalHistoryListField(
                  label: 'Limited Activities',
                  values: [
                    'knee: Difficulty walking',
                    'Sleep disturbed',
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Gait & Movement Analysis',
                child: ClinicalHistoryField(label: 'Analysis', value: ''),
              ),

              const ClinicalHistorySectionCard(
                title: 'Past Medical History & Treatment',
                child: Column(
                  children: [
                    ClinicalHistoryListField(
                      label: 'Medical History',
                      values: ['Previous knee/thigh injury'],
                    ),
                    ClinicalHistoryListField(
                      label: 'History Details',
                      values: [],
                    ),
                    ClinicalHistoryField(label: 'Surgical History', value: ''),
                    ClinicalHistoryListField(
                      label: 'Previous Treatments',
                      values: ['Physiotherapy'],
                    ),
                    ClinicalHistoryField(
                      label: 'Physiotherapy Response',
                      value: 'Improved',
                    ),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Investigations & Reports',
                child: ClinicalHistoryListField(
                  label: 'Investigations Done',
                  values: ['xray', 'MRI'],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Red Flags',
                child: ClinicalHistoryListField(label: 'Flags', values: []),
              ),

              const ClinicalHistorySectionCard(
                title: 'Face: Onset & Course',
                child: Column(
                  children: [
                    ClinicalHistoryField(label: 'Onset', value: ''),
                    ClinicalHistoryField(label: 'Duration', value: ''),
                    ClinicalHistoryListField(label: 'Course', values: []),
                    ClinicalHistoryField(label: 'Cold Exposure', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Face: Eye Involvement',
                child: AppTabletFieldsGrid(
                  phoneColumns: 1,
                  tabletColumns: 2,
                  children: [
                    ClinicalHistoryField(label: 'Eye Closure Fully', value: ''),
                    ClinicalHistoryField(label: 'Eye Closure %', value: '0'),
                    ClinicalHistoryField(label: 'Eye Dryness', value: ''),
                    ClinicalHistoryField(label: 'Eye Dryness %', value: '0'),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Speech, Eating & Drinking',
                child: ClinicalHistoryListField(label: 'Assessment', values: []),
              ),

              const ClinicalHistorySectionCard(
                title: 'Face-Specific Pain',
                child: Column(
                  children: [
                    ClinicalHistoryField(label: 'Pain Present', value: ''),
                    ClinicalHistoryListField(label: 'Location', values: []),
                    ClinicalHistoryField(label: 'Intensity', value: '0'),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'Household Work',
                child: Column(
                  children: [
                    ClinicalHistoryField(label: 'Status', value: 'yes'),
                    ClinicalHistoryListField(
                      label: 'Tasks',
                      values: ['cooking, meal_preparation'],
                    ),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'For Women Only',
                child: AppTabletFieldsGrid(
                  phoneColumns: 1,
                  tabletColumns: 2,
                  children: [
                    ClinicalHistoryField(label: 'Married since', value: ''),
                    ClinicalHistoryField(label: 'Has children', value: ''),
                    ClinicalHistoryField(label: 'Special child', value: ''),
                    ClinicalHistoryField(label: 'Is pregnant', value: ''),
                    ClinicalHistoryField(label: 'Pregnancy type', value: ''),
                    ClinicalHistoryField(label: 'Previous pregnancy', value: ''),
                    ClinicalHistoryField(label: 'Delivery type', value: ''),
                    ClinicalHistoryField(label: 'Cycle regular', value: ''),
                    ClinicalHistoryField(label: 'Cycle describe', value: ''),
                    ClinicalHistoryField(label: 'Period discomfort', value: ''),
                    ClinicalHistoryField(label: 'Period pain describe', value: ''),
                    ClinicalHistoryField(label: 'Gyne conditions', value: ''),
                    ClinicalHistoryField(label: 'Gyne describe', value: ''),
                    ClinicalHistoryField(label: 'Intercourse pain', value: ''),
                    ClinicalHistoryField(label: 'Has IUD', value: ''),
                    ClinicalHistoryField(label: 'Urine leakage', value: ''),
                    ClinicalHistoryField(label: 'Nocturia', value: ''),
                  ],
                ),
              ),

              const ClinicalHistorySectionCard(
                title: 'For Men Only',
                child: AppTabletFieldsGrid(
                  phoneColumns: 1,
                  tabletColumns: 2,
                  children: [
                    ClinicalHistoryField(label: 'Urination pain', value: ''),
                    ClinicalHistoryField(label: 'Urine leakage', value: ''),
                    ClinicalHistoryField(label: 'Nocturia', value: ''),
                    ClinicalHistoryField(label: 'Genital numbness', value: ''),
                    ClinicalHistoryField(
                      label: 'Bladder/Sexual worsening',
                      value: '',
                    ),
                  ],
                ),
              ),
            ],
    );

    final scrollView = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 24.h),
      child: reportContent,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Clinical History'),
      body: SafeArea(
        child: isTablet
            ? Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppDevice.contentMaxWidth(context),
                  ),
                  child: scrollView,
                ),
              )
            : scrollView,
      ),
    );
  }
}
