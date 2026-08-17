import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_card.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_modality_chip.dart';

// ============================================================
// THERAPY SESSIONS PAGE
// ------------------------------------------------------------
// Compact session cards list (app brand colors).
// ============================================================

class TherapySessionsPage extends StatelessWidget {
  const TherapySessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'All Sessions'),
      body: AppTabletSafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            Text(
              '1 therapy session',
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            const TherapySessionCard(
              initiallyExpanded: true,
              sessionNumber: 1,
              patientName: 'Saima Raees',
              cnic: '82401-9475130-9',
              ageGender: '35 Y / Female',
              therapist: 'DR TAHNIAT ZEHRA NAQVI',
              packageName: '10 days package 30000',
              duration: '00:40:22',
              startedAt: '04:36 PM',
              endedAt: '05:16 PM',
              modalities: [
                TherapySessionModalityChip(title: 'IFC', duration: '10m'),
                TherapySessionModalityChip(
                  title: 'Ultrasound',
                  duration: '5m',
                ),
                TherapySessionModalityChip(
                  title: 'Thermotherapy',
                  duration: '10m',
                ),
              ],
              nextDate: '08 Aug, 2026',
              nextTimeSlot: '04:00 - 04:05 PM',
            ),
          ],
        ),
      ),
    );
  }
}
