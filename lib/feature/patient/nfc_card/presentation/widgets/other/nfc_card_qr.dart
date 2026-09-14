import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';

// ============================================================
// NFC CARD QR
// ------------------------------------------------------------
// Small white QR box (same icon as doctor-app).
// ============================================================

class NfcCardQr extends StatelessWidget {
  const NfcCardQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 25.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Icon(
        Icons.qr_code,
        size: AppSizes.iconSm,
        color: AppColors.textPrimary,
      ),
    );
  }
}
