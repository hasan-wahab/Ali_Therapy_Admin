import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_action_type.dart';

// ============================================================
// PATIENT ACTIONS BUTTON
// ------------------------------------------------------------
// Compact teal "Actions" popup menu.
// ============================================================

class PatientActionsButton extends StatelessWidget {
  const PatientActionsButton({
    super.key,
    this.onSelected,
  });

  final ValueChanged<PatientActionType>? onSelected;

  static const Color _deleteColor = Color(0xFFE57373);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PatientActionType>(
      onSelected: onSelected,
      offset: Offset(0, 6.h),
      color: AppColors.surface,
      elevation: 6,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: AppColors.border),
      ),
      itemBuilder: (context) => [
        _menuItem(
          type: PatientActionType.view,
          icon: Icons.visibility_outlined,
          label: 'View',
          color: AppColors.primary,
        ),
        _menuItem(
          type: PatientActionType.edit,
          icon: Icons.edit_note_rounded,
          label: 'Edit',
          color: AppColors.primary,
        ),
        const PopupMenuDivider(height: 1),
        _menuItem(
          type: PatientActionType.delete,
          icon: Icons.delete_outline_rounded,
          label: 'Delete',
          color: _deleteColor,
        ),
      ],
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Actions',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: AppSizes.iconSm,
              color: AppColors.textOnPrimary,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<PatientActionType> _menuItem({
    required PatientActionType type,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return PopupMenuItem<PatientActionType>(
      value: type,
      height: 40.h,
      child: Row(
        children: [
          Icon(icon, size: AppSizes.iconMd, color: color),
          SizedBox(width: 10.w),
          Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
