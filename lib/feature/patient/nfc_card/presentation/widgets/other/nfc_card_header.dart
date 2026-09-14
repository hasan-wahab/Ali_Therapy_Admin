import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_logo.dart';

// ============================================================
// NFC CARD HEADER
// ------------------------------------------------------------
// Clinic title + address + logo (doctor-app NFC card top bar).
// ============================================================

class NfcCardHeader extends StatelessWidget {
  const NfcCardHeader({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.nfcCard,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DR. ALI THERAPY',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'PATIENT IDENTIFICATION CARD',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: 9.sp,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  address,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textOnPrimary,
                    fontSize: 8.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          const NfcCardLogo(),
        ],
      ),
    );
  }
}
