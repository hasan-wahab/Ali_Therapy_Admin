import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_chip.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_data.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_info_row.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_photo.dart';

// ============================================================
// NFC CARD MIDDLE
// ------------------------------------------------------------
// Photo + chip + patient name / ID / phone / CNIC / blood.
// ============================================================

class NfcCardMiddle extends StatelessWidget {
  const NfcCardMiddle({
    super.key,
    required this.data,
  });

  final NfcCardData data;

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textOnPrimary,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NfcCardPhoto(photoUrl: data.photoUrl),
                const NfcCardChip(),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'ID  ${data.patientId}',
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  NfcCardInfoRow(label: 'PHONE', value: data.phone),
                  NfcCardInfoRow(label: 'CNIC', value: data.cnic),
                  NfcCardInfoRow(label: 'BLOOD', value: data.bloodGroup),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
