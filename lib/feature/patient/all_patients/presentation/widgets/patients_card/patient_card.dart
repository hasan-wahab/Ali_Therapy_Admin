import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/delete_patient_dialog.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_action_type.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_actions_button.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_balance_block.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_problem_chips.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_section_title.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_sessions_block.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_staff_block.dart';
import 'package:ali_therapy_admin/core/widgets/app_expandable_card.dart';

// ============================================================
// PATIENT CARD
// ------------------------------------------------------------
// Clear labeled sections — ~2 cards visible without scroll.
// ============================================================

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patientId,
    required this.name,
    required this.cnic,
    required this.problems,
    required this.insurance,
    required this.totalBilled,
    required this.paid,
    required this.discount,
    required this.insuranceAmount,
    required this.remaining,
    required this.remainingSessions,
    required this.createdBy,
    required this.createdDate,
    this.totalSessions = 0,
    this.receptionist = '—',
    this.assistantManager = '—',
    this.historyTaker = '—',
    this.consultant = '—',
    this.therapist = '—',
    this.onActionSelected,
    this.initiallyExpanded = false,
  });

  final String patientId;
  final String name;
  final String cnic;
  final String problems;
  final String insurance;
  final String totalBilled;
  final String paid;
  final String discount;
  final String insuranceAmount;
  final String remaining;
  final int remainingSessions;
  final int totalSessions;
  final String createdBy;
  final String createdDate;
  final String receptionist;
  final String assistantManager;
  final String historyTaker;
  final String consultant;
  final String therapist;
  final ValueChanged<PatientActionType>? onActionSelected;

  final bool initiallyExpanded;
  void _handleAction(BuildContext context, PatientActionType type) {
    if (onActionSelected != null) {
      onActionSelected!(type);
      return;
    }

    if (type == PatientActionType.view) {
      AppNavigation.openPatientDetail(context);
      return;
    }

    if (type == PatientActionType.edit) {
      AppNavigation.openEditPatient(context);
      return;
    }

    if (type == PatientActionType.delete) {
      showDeletePatientDialog(context, patientName: name);
      return;
    }

    // UI only — wire remaining actions later.
    AppSnackbar.info(context, '${type.name} tapped');
  }

  @override
  Widget build(BuildContext context) {
    return AppExpandableCard(
      initiallyExpanded: initiallyExpanded,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: name / CNIC / ID left, Actions right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          size: AppSizes.iconSm,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'CNIC: ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            cnic,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Text(
                          'Patient ID: ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        Text(
                          patientId,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              PatientActionsButton(
                onSelected: (type) => _handleAction(context, type),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Problems + Insurance
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PatientSectionTitle(title: 'Problems'),
                    SizedBox(height: 4.h),
                    PatientProblemChips(problems: problems),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PatientSectionTitle(title: 'Insurance'),
                    SizedBox(height: 4.h),
                    Text(
                      insurance,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Balance + Sessions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: PatientBalanceBlock(
                  totalBilled: totalBilled,
                  paid: paid,
                  discount: discount,
                  insurance: insuranceAmount,
                  remaining: remaining,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 5,
                child: PatientSessionsBlock(
                  remainingSessions: remainingSessions,
                  totalSessions: totalSessions,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Staff details (full)
          PatientStaffBlock(
            createdBy: createdBy,
            receptionist: receptionist,
            assistantManager: assistantManager,
            historyTaker: historyTaker,
            consultant: consultant,
            therapist: therapist,
          ),
          SizedBox(height: 8.h),

          // Created date
          Row(
            children: [
              Text(
                'Created Date: ',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              Expanded(
                child: Text(
                  createdDate,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.border,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
