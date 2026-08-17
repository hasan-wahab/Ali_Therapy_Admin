import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_history_header.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/patient_dues_history_table.dart';

// ============================================================
// PATIENT DUES HISTORY PAGE
// ------------------------------------------------------------
// Invoice-level dues history for one patient.
// ============================================================

class PatientDuesHistoryPage extends StatelessWidget {
  const PatientDuesHistoryPage({
    super.key,
    required this.patientName,
    required this.cnic,
    required this.phone,
  });

  final String patientName;
  final String cnic;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppTabletSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PatientDuesHistoryHeader(
              patientName: patientName,
              cnic: cnic,
              phone: phone,
            ),
            Divider(height: 1.h, color: AppColors.divider),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const PatientDuesHistoryTable(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () => AppNavigation.back(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.info,
                      foregroundColor: AppColors.textOnPrimary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
