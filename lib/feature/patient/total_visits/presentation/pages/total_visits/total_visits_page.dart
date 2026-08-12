import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/total_visits/presentation/widgets/other/total_visit_card.dart';

// ============================================================
// TOTAL VISITS PAGE
// ------------------------------------------------------------
// Mobile list of visit cards (sample data from Total Visit table).
// ============================================================

class TotalVisitsPage extends StatelessWidget {
  const TotalVisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Total Visits'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            Text(
              '2 visits',
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            const TotalVisitCard(
              date: 'Aug 07, 2026',
              type: 'Consultation',
              doctor: 'Dr. Wajid Mian',
              stage: 'Assistant manager',
              amount: 'Rs. 3,000.00',
            ),
            SizedBox(height: 12.h),
            const TotalVisitCard(
              date: 'Aug 07, 2026',
              type: 'Consultation',
              doctor: 'Dr. Ayesha Khan',
              stage: 'Assistant manager',
              amount: 'Rs. 3,000.00',
            ),
          ],
        ),
      ),
    );
  }
}
