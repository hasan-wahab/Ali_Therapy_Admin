import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_field.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_list_field.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_muscle_card.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_region_grid.dart';
import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_section_card.dart';

// ============================================================
// CONSULTANT DETAILS PAGE
// ------------------------------------------------------------
// Consultant Assessment report — all API fields (empty → —).
// Stops at Selected Packages (no print / footer actions).
// ============================================================

class ConsultantDetailsPage extends StatelessWidget {
  const ConsultantDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Consultant Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header summary
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
                      'Assessment #1093  ·  Visit #9469',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      '07 Aug 2026, 06:47 PM',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                    Text(
                      'Consultant: DR HIRA HASSAN',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const ConsultantSectionCard(
                title: 'Clinical Findings & Diagnosis',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConsultantListField(
                      label: 'Diagnosis',
                      values: ['Other Diagnosis'],
                    ),
                    ConsultantField(
                      label: 'Note',
                      value:
                          'Right Side Hemiplegia\nGeneralised Body Weakness',
                    ),
                  ],
                ),
              ),

              const ConsultantSectionCard(
                title: 'Session Settings',
                child: ConsultantField(
                  label: 'Prescribed Session Duration',
                  value: '6m 15s',
                ),
              ),

              const ConsultantSectionCard(
                title: 'Advice',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConsultantListField(
                      label: 'Investigations Done',
                      values: [],
                    ),
                    ConsultantField(
                      label: 'Other Investigations / Advice',
                      value: '',
                    ),
                  ],
                ),
              ),

              const ConsultantSectionCard(
                title: 'Special Tests Examination',
                child: ConsultantRegionGrid(
                  regions: {
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
                  },
                ),
              ),

              const ConsultantSectionCard(
                title: 'Manual Muscle Testing (MMT)',
                child: ConsultantRegionGrid(
                  regions: {
                    'Upper Limb': '',
                    'Lower Limb': '',
                  },
                ),
              ),

              ConsultantSectionCard(
                title: 'Muscle Assessments / Exercises',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    ConsultantMuscleCard(
                      initiallyExpanded: true,
                      muscle: 'Quadriceps',
                      conditions: ['Muscle spasm'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                        'PNF Exercises — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Bicep femoris',
                      conditions: ['Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Semitendinosus',
                      conditions: ['Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Semimembranosus',
                      conditions: ['Muscle spasm', 'Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Gastrocnemius',
                      conditions: ['Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [],
                      defaultExercises: ['Ankle pump without hold'],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Soleus',
                      conditions: ['Muscle spasm', 'Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Flexor carpi radialis',
                      conditions: ['Joint stiffness', 'Contracture'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        "Stretching's — 5 sets x 5 reps x 1 Sets x 10 days",
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Flexor carpi ulnaris',
                      conditions: ['Limited ROM'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Supraspinatus',
                      conditions: ['Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Infraspinatus',
                      conditions: ['Muscle spasm', 'Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Teres major',
                      conditions: ['Weak muscle'],
                      manualTreatments: [],
                      otherTreatment: '',
                      prescribedExercises: [
                        'ROMS — 5 sets x 5 reps x 2 Sets x 10 days',
                      ],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Teres minor',
                      conditions: ['Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [],
                      defaultExercises: [],
                    ),
                    ConsultantMuscleCard(
                      muscle: 'Deltoid',
                      conditions: ['Muscle spasm', 'Weak muscle'],
                      manualTreatments: ['Active release'],
                      otherTreatment: '',
                      prescribedExercises: [],
                      defaultExercises: [],
                    ),
                  ],
                ),
              ),

              const ConsultantSectionCard(
                title: 'General Therapeutic Prescription',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConsultantField(
                      label: 'Electrotherapy',
                      value: 'RUSSIAN (Time: 10m)',
                    ),
                    ConsultantField(
                      label: 'Thermo / Cryotherapy',
                      value: 'Thermotherapy (by default) (Time: 10m)',
                    ),
                    ConsultantField(
                      label: 'Anti-Inflammatory Modalities',
                      value: '',
                    ),
                    ConsultantField(label: 'Advanced Techniques', value: ''),
                    ConsultantField(label: 'Medications', value: ''),
                    ConsultantField(label: 'Topicals', value: ''),
                  ],
                ),
              ),

              // Last section — no print / footer below this
              const ConsultantSectionCard(
                title: 'Selected Packages',
                child: ConsultantListField(
                  label: 'Assigned Packages',
                  values: ['15 Days package'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
