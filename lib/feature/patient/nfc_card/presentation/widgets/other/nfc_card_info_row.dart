import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// NFC CARD INFO ROW
// ------------------------------------------------------------
// PHONE / CNIC / BLOOD line — same split as doctor-app.
// ============================================================

class NfcCardInfoRow extends StatelessWidget {
  const NfcCardInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textOnPrimary,
      fontSize: 8.sp,
      letterSpacing: 1,
    );

    return SizedBox(
      width: 170.w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: style),
          ),
          Expanded(
            flex: 1,
            child: Text(':', style: style),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value.trim().isEmpty ? '—' : value,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
