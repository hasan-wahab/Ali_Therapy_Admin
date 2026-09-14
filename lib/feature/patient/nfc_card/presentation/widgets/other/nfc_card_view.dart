import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_data.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_footer.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_header.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_middle.dart';

// ============================================================
// NFC CARD VIEW
// ------------------------------------------------------------
// Patient identification card — copied from doctor-app NFC UI.
// ============================================================

class NfcCardView extends StatelessWidget {
  const NfcCardView({
    super.key,
    required this.data,
  });

  final NfcCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: AppColors.nfcCard,
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          NfcCardHeader(address: data.address),
          NfcCardMiddle(data: data),
          NfcCardFooter(
            cardUrl: data.cardUrl,
            clinicPhone: data.clinicPhone,
            cardNumber: data.cardNumber,
          ),
        ],
      ),
    );
  }
}
