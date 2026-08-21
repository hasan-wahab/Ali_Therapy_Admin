import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_card.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';

// ============================================================
// PATIENT CARD LIST
// ------------------------------------------------------------
// Sample patients for All Patients (UI only).
// ============================================================

class PatientCardList extends StatelessWidget {
  const PatientCardList({
    super.key,
    this.searchQuery = '',
    this.receptionist = PatientsFiltersPanel.allReceptionists,
  });

  final String searchQuery;
  final String receptionist;

  static const _samplePatients = [
    (
      patientId: '1073',
      name: 'Khawar Abbas',
      cnic: '61101-1825302-9',
      problems: 'Ankle Foot, Elbow, Forearm, Wrist, Hand / Fingers, Shoulder, Knee pain',
      insurance: 'N/A',
      totalBilled: 'PKR 78,000',
      paid: 'PKR 8,000',
      discount: 'PKR 37,500',
      insuranceAmount: 'PKR 0',
      remaining: 'PKR 32,500',
      remainingSessions: 14,
      totalSessions: 15,
      createdBy: 'SANA MAJEED',
      receptionist: 'SANA MAJEED',
      assistantManager: 'DR HIRA HASSAN',
      historyTaker: 'DR HIRA HASSAN',
      consultant: 'Arsalan Neuro Clinic',
      therapist: 'DR AZLAN KHAN',
      createdDate: '08/06/26 12:17',
    ),
    (
      patientId: '1024',
      name: 'Ayesha Bibi',
      cnic: '35202-1234567-8',
      problems: 'Back pain, Neck stiffness',
      insurance: 'State Life',
      totalBilled: 'PKR 12,000',
      paid: 'PKR 5,000',
      discount: 'PKR 500',
      insuranceAmount: 'PKR 2,000',
      remaining: 'PKR 4,500',
      remainingSessions: 4,
      totalSessions: 10,
      createdBy: 'Super Admin',
      receptionist: 'SANA MAJEED',
      assistantManager: 'DR HIRA HASSAN',
      historyTaker: '—',
      consultant: 'Ali Therapy',
      therapist: 'DR AZLAN KHAN',
      createdDate: '07/07/26 11:20',
    ),
    (
      patientId: '1025',
      name: 'Ali Raza',
      cnic: '61101-9988776-5',
      problems: 'Stroke rehab',
      insurance: 'N/A',
      totalBilled: 'PKR 25,000',
      paid: 'PKR 25,000',
      discount: 'PKR 0',
      insuranceAmount: 'PKR 0',
      remaining: 'PKR 0',
      remainingSessions: 0,
      totalSessions: 12,
      createdBy: 'Reception Desk',
      receptionist: 'SANA MAJEED',
      assistantManager: '—',
      historyTaker: 'DR HIRA HASSAN',
      consultant: '—',
      therapist: 'DR AZLAN KHAN',
      createdDate: '06/07/26 09:45',
    ),
  ];

  static List<
      ({
        String patientId,
        String name,
        String cnic,
        String problems,
        String insurance,
        String totalBilled,
        String paid,
        String discount,
        String insuranceAmount,
        String remaining,
        int remainingSessions,
        int totalSessions,
        String createdBy,
        String receptionist,
        String assistantManager,
        String historyTaker,
        String consultant,
        String therapist,
        String createdDate,
      })> _filtered({required String receptionist}) {
    if (receptionist == PatientsFiltersPanel.allReceptionists) {
      return _samplePatients;
    }
    return _samplePatients
        .where((patient) => patient.receptionist == receptionist)
        .toList();
  }

  static bool hasRows({required String receptionist}) {
    return _filtered(receptionist: receptionist).isNotEmpty;
  }

  static int matchCountFor(String query, {required String receptionist}) {
    return AppSearchRanker.matchCount(
      items: _filtered(receptionist: receptionist),
      query: query,
      fieldsOf: _searchFields,
    );
  }

  static List<String> _searchFields(
    ({
      String patientId,
      String name,
      String cnic,
      String problems,
      String insurance,
      String totalBilled,
      String paid,
      String discount,
      String insuranceAmount,
      String remaining,
      int remainingSessions,
      int totalSessions,
      String createdBy,
      String receptionist,
      String assistantManager,
      String historyTaker,
      String consultant,
      String therapist,
      String createdDate,
    }) patient,
  ) =>
      [
        patient.name,
        patient.patientId,
        patient.cnic,
        patient.problems,
        patient.insurance,
        patient.createdBy,
        patient.receptionist,
        patient.assistantManager,
        patient.consultant,
        patient.therapist,
      ];

  @override
  Widget build(BuildContext context) {
    final patients = AppSearchRanker.matchesThenRelated(
      items: _filtered(receptionist: receptionist),
      query: searchQuery,
      fieldsOf: _searchFields,
    );

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
          patientId: patient.patientId,
          name: patient.name,
          cnic: patient.cnic,
          problems: patient.problems,
          insurance: patient.insurance,
          totalBilled: patient.totalBilled,
          paid: patient.paid,
          discount: patient.discount,
          insuranceAmount: patient.insuranceAmount,
          remaining: patient.remaining,
          remainingSessions: patient.remainingSessions,
          totalSessions: patient.totalSessions,
          createdBy: patient.createdBy,
          receptionist: patient.receptionist,
          assistantManager: patient.assistantManager,
          historyTaker: patient.historyTaker,
          consultant: patient.consultant,
          therapist: patient.therapist,
          createdDate: patient.createdDate,
        );
      },
    );
  }
}
