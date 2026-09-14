import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';

// ============================================================
// NFC CARD CHIP
// ------------------------------------------------------------
// SIM chip image from doctor-app (assets/images/sim_chip.png).
// ============================================================

class NfcCardChip extends StatelessWidget {
  const NfcCardChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(width: 1.w, color: AppColors.surface),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppConstants.nfcCardChip),
        ),
      ),
    );
  }
}
