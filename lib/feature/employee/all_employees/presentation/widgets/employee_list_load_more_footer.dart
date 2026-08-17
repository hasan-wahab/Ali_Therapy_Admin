import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// EMPLOYEE LIST LOAD MORE FOOTER
// ------------------------------------------------------------
// Small spinner under the list while next page loads.
// ============================================================

class EmployeeListLoadMoreFooter extends StatelessWidget {
  const EmployeeListLoadMoreFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: SizedBox(
          width: 22.w,
          height: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
