import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_experience_entry_card.dart';

// ============================================================
// EXPERIENCE FORM FIELDS
// ------------------------------------------------------------
// List of experience entries + Add Experience.
// ============================================================

class EditExperienceFormFields extends StatelessWidget {
  const EditExperienceFormFields({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final entries = form.experiences;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              EditExperienceEntryCard(
                companyController: entries[i].company,
                periodController: entries[i].period,
                dutiesController: entries[i].duties,
                supervisorController: entries[i].supervisor,
                onDelete: () => form.removeExperience(i),
              ),
              if (i < entries.length - 1) SizedBox(height: 12.h),
            ],
            SizedBox(height: 14.h),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: form.addExperience,
                icon: Icon(Icons.add, size: AppSizes.iconSm),
                label: Text(
                  'Add Experience',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 1.5.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
