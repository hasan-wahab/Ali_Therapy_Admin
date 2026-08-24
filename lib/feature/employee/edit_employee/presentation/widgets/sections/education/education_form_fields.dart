import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_education_entry_card.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';

// ============================================================
// EDUCATION FORM FIELDS
// ------------------------------------------------------------
// List of education entries + Add Education.
// ============================================================

class EditEducationFormFields extends StatelessWidget {
  const EditEducationFormFields({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final entries = form.educations;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              EditEducationEntryCard(
                degreeController: entries[i].degree,
                universityController: entries[i].university,
                cgpaController: entries[i].cgpa,
                commentsController: entries[i].comments,
                onDelete: () => form.removeEducation(i),
              ),
              if (i < entries.length - 1) SizedBox(height: 12.h),
            ],
            SizedBox(height: 14.h),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: form.addEducation,
                icon: Icon(Icons.add, size: AppSizes.iconSm),
                label: Text(
                  'Add Education',
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
