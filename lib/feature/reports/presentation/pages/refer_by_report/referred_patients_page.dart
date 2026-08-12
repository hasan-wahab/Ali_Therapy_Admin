import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_item_card.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/referred_patients_toolbar.dart';

// ============================================================
// REFERRED PATIENTS PAGE
// ------------------------------------------------------------
// Refer By report detail: patients under one referral source.
// ============================================================

class ReferredPatientsPage extends StatelessWidget {
  const ReferredPatientsPage({
    super.key,
    required this.referralSource,
    required this.patientCount,
  });

  final String referralSource;
  final int patientCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Referred Patients'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReferredPatientsHeader(referralSource: referralSource),
            ReferredPatientsToolbar(totalPatients: patientCount),
            Divider(height: 1.h, color: AppColors.divider),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                children: const [
                  ReferredPatientsItemCard(
                    index: 1,
                    patientName: 'Fatima Musharf',
                    patientId: 'PAT-1105',
                    phone: '0333-5211131',
                    cnic: '37405-8715279-6',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    regDate: '10 Aug 2026',
                  ),
                  ReferredPatientsItemCard(
                    index: 2,
                    patientName: 'Asia Noreen',
                    patientId: 'PAT-1098',
                    phone: '0331-0303882',
                    cnic: '37105-0248077-0',
                    clinic: 'Clinic 1 (Ortho)',
                    regDate: '08 Aug 2026',
                  ),
                  ReferredPatientsItemCard(
                    index: 3,
                    patientName: 'Muhammad Ali',
                    patientId: 'PAT-1082',
                    phone: '0321-9988776',
                    cnic: '35202-4455667-1',
                    clinic: 'Clinic 3 (Neuro and Stroke)',
                    regDate: '05 Aug 2026',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
