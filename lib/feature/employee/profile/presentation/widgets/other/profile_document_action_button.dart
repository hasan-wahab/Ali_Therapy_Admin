import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';

// ============================================================
// PROFILE DOCUMENT ACTION BUTTON
// ------------------------------------------------------------
// Small bordered icon button on a document row.
// ============================================================

class ProfileDocumentActionButton extends StatelessWidget {
  const ProfileDocumentActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color, size: AppSizes.iconSm),
      ),
    );
  }
}
