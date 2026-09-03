import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patient_entity.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patient_card_mapper.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_card.dart';

// ============================================================
// PATIENT CARD LIST
// ------------------------------------------------------------
// Builds cards from API patients (empty values show as "_").
// ============================================================

class PatientCardList extends StatelessWidget {
  const PatientCardList({
    super.key,
    required this.patients,
  });

  final List<PatientEntity> patients;

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No patients found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: patients.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientCard(
          initiallyExpanded: index == 0,
          patientId: PatientCardMapper.patientId(patient),
          name: PatientCardMapper.name(patient),
          cnic: PatientCardMapper.cnic(patient),
          problems: PatientCardMapper.problems(patient),
          insurance: PatientCardMapper.insurance(patient),
          totalBilled: PatientCardMapper.totalBilled(patient),
          paid: PatientCardMapper.paid(patient),
          discount: PatientCardMapper.discount(patient),
          insuranceAmount: PatientCardMapper.insuranceAmount(patient),
          remaining: PatientCardMapper.remaining(patient),
          remainingSessions: patient.remainingSessions,
          totalSessions: patient.totalSessions,
          createdBy: PatientCardMapper.createdBy(patient),
          receptionist: PatientCardMapper.receptionist(patient),
          assistantManager: PatientCardMapper.assistantManager(patient),
          historyTaker: PatientCardMapper.historyTaker(patient),
          consultant: PatientCardMapper.consultant(patient),
          therapist: PatientCardMapper.therapist(patient),
          createdDate: PatientCardMapper.createdDate(patient),
        );
      },
    );
  }
}
