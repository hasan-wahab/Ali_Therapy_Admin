import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// FORM SCREEN HEADER
// ------------------------------------------------------------
// Title + short subtitle under the AppBar (login-style spacing).
// ============================================================

class FormScreenHeader extends StatelessWidget {
  const FormScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading2),
        SizedBox(height: 8.h),
        Text(subtitle, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
