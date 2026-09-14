import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';

// ============================================================
// NFC CARD PHOTO
// ------------------------------------------------------------
// Patient photo box. Shows a placeholder when there is no URL.
// ============================================================

class NfcCardPhoto extends StatelessWidget {
  const NfcCardPhoto({
    super.key,
    required this.photoUrl,
  });

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl.trim().isNotEmpty;

    return Container(
      height: 52.h,
      width: 50.w,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: AppColors.surface),
      ),
      child: hasPhoto
          ? Image.network(
              photoUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image,
                size: AppSizes.iconMd,
                color: AppColors.textMuted,
              ),
            )
          : Icon(
              Icons.image,
              size: AppSizes.iconMd,
              color: AppColors.textMuted,
            ),
    );
  }
}
