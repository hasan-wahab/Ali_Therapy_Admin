import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';

// ============================================================
// NFC CARD LOGO
// ------------------------------------------------------------
// White rounded box + clinic logo (doctor-app main_logo.png).
// ============================================================

class NfcCardLogo extends StatelessWidget {
  const NfcCardLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 45.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Image.asset(
        AppConstants.nfcCardLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}
