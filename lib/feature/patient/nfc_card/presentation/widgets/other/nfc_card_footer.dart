import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_qr.dart';

// ============================================================
// NFC CARD FOOTER
// ------------------------------------------------------------
// Website, clinic phone, card number, QR (doctor-app bottom bar).
// ============================================================

class NfcCardFooter extends StatelessWidget {
  const NfcCardFooter({
    super.key,
    required this.cardUrl,
    required this.clinicPhone,
    required this.cardNumber,
  });

  final String cardUrl;
  final String clinicPhone;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textOnPrimary,
      fontSize: 8.sp,
      letterSpacing: 1,
    );

    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.nfcCard,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cardUrl,
                  style: style,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(clinicPhone, style: style),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          Text(cardNumber, style: style),
          SizedBox(width: 6.w),
          const NfcCardQr(),
        ],
      ),
    );
  }
}
