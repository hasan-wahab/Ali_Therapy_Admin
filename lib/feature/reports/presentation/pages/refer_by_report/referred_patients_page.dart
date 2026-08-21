import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_item_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_toolbar.dart';

// ============================================================
// REFERRED PATIENTS PAGE
// ------------------------------------------------------------
// Refer By report detail: patients under one referral source.
// ============================================================

class ReferredPatientsPage extends StatefulWidget {
  const ReferredPatientsPage({
    super.key,
    required this.referralSource,
    required this.patientCount,
  });

  final String referralSource;
  final int patientCount;

  @override
  State<ReferredPatientsPage> createState() => _ReferredPatientsPageState();
}

class _ReferredPatientsPageState extends State<ReferredPatientsPage> {
  static const _debounceDuration = Duration(milliseconds: 450);

  String _searchQuery = '';
  Timer? _searchDebounce;

  static const _samplePatients = [
    (
      patientName: 'Fatima Musharf',
      patientId: 'PAT-1105',
      phone: '0333-5211131',
      cnic: '37405-8715279-6',
      clinic: 'Clinic 3 (Neuro and Stroke)',
      regDate: '10 Aug 2026',
    ),
    (
      patientName: 'Asia Noreen',
      patientId: 'PAT-1098',
      phone: '0331-0303882',
      cnic: '37105-0248077-0',
      clinic: 'Clinic 1 (Ortho)',
      regDate: '08 Aug 2026',
    ),
    (
      patientName: 'Muhammad Ali',
      patientId: 'PAT-1082',
      phone: '0321-9988776',
      cnic: '35202-4455667-1',
      clinic: 'Clinic 3 (Neuro and Stroke)',
      regDate: '05 Aug 2026',
    ),
  ];

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      if (!mounted) return;
      setState(() => _searchQuery = value);
    });
  }

  void _onSearchSubmitted(String value) {
    _searchDebounce?.cancel();
    setState(() => _searchQuery = value);
  }

  @override
  Widget build(BuildContext context) {
    final patients = AppSearchRanker.matchesThenRelated(
      items: _samplePatients,
      query: _searchQuery,
      fieldsOf: (patient) => [
        patient.patientName,
        patient.patientId,
        patient.phone,
        patient.cnic,
        patient.clinic,
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Referred Patients'),
      body: AppTabletSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReferredPatientsHeader(referralSource: widget.referralSource),
            ReferredPatientsToolbar(
              totalPatients: widget.patientCount,
              searchQuery: _searchQuery,
              searchMatchCount: AppSearchRanker.matchCount(
                items: patients,
                query: _searchQuery,
                fieldsOf: (patient) => [
                  patient.patientName,
                  patient.patientId,
                  patient.phone,
                  patient.cnic,
                  patient.clinic,
                ],
              ),
              listIsEmpty: patients.isEmpty,
              onSearchChanged: _onSearchChanged,
              onSearchSubmitted: _onSearchSubmitted,
            ),
            Divider(height: 1.h, color: AppColors.divider),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return ReferredPatientsItemCard(
                    index: index + 1,
                    patientName: patient.patientName,
                    patientId: patient.patientId,
                    phone: patient.phone,
                    cnic: patient.cnic,
                    clinic: patient.clinic,
                    regDate: patient.regDate,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
