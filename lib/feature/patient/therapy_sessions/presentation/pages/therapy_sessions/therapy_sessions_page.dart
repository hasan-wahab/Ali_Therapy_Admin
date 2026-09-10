import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_card.dart';
import 'package:ali_therapy_admin/feature/patient/therapy_sessions/presentation/widgets/other/therapy_session_modality_chip.dart';

// ============================================================
// THERAPY SESSIONS PAGE
// ------------------------------------------------------------
// Sessions from Patient Full View (passed via extra).
// Pull refresh reloads Full View — AppBar underline loading.
// ============================================================

class TherapySessionsPage extends StatelessWidget {
  const TherapySessionsPage({super.key});

  String _ageGender({required int age, required String gender}) {
    final ageText = age > 0 ? '$age Y' : PatientDetailDisplay.empty;
    final genderText = PatientDetailDisplay.titled(gender);
    if (ageText == PatientDetailDisplay.empty &&
        genderText == PatientDetailDisplay.empty) {
      return PatientDetailDisplay.empty;
    }
    if (ageText == PatientDetailDisplay.empty) return genderText;
    if (genderText == PatientDetailDisplay.empty) return ageText;
    return '$ageText / $genderText';
  }

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'All Sessions',
      builder: (context, detail) {
        final sessions = detail.sessions;

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          itemCount: sessions.length + 1,
          separatorBuilder: (_, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            if (index == 0) {
              final count = sessions.length;
              return Text(
                count == 1 ? '1 therapy session' : '$count therapy sessions',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            final session = sessions[index - 1];
            return TherapySessionCard(
              initiallyExpanded: index == 1,
              sessionNumber: session.sessionNumber,
              patientName: PatientDetailDisplay.titled(session.patientName),
              cnic: PatientDetailDisplay.text(session.cnic),
              ageGender: _ageGender(
                age: session.age,
                gender: session.gender,
              ),
              therapist: PatientDetailDisplay.titled(session.therapist),
              packageName: PatientDetailDisplay.titled(session.packageName),
              duration: PatientDetailDisplay.text(session.duration),
              startedAt: PatientDetailDisplay.text(session.startedAt),
              endedAt: PatientDetailDisplay.text(session.endedAt),
              modalities: session.modalities
                  .map(
                    (item) => TherapySessionModalityChip(
                      title: PatientDetailDisplay.titled(item.title),
                      duration: PatientDetailDisplay.text(item.duration),
                    ),
                  )
                  .toList(),
              nextDate: PatientDetailDisplay.date(session.nextSession.date),
              nextTimeSlot: PatientDetailDisplay.text(
                session.nextSession.timeSlot,
              ),
            );
          },
        );
      },
    );
  }
}
