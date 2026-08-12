import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';

// ============================================================
// EDIT EXPERIENCE ENTRY CARD
// ------------------------------------------------------------
// One experience row: company, period, duties, supervisor, delete.
// ============================================================

class EditExperienceEntryCard extends StatelessWidget {
  const EditExperienceEntryCard({
    super.key,
    required this.companyController,
    required this.periodController,
    required this.dutiesController,
    required this.supervisorController,
    required this.onDelete,
  });

  final TextEditingController companyController;
  final TextEditingController periodController;
  final TextEditingController dutiesController;
  final TextEditingController supervisorController;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Company Name',
                  hintText: 'Company Name',
                  controller: companyController,
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 28.h),
                child: InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: AppColors.errorSoft,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          EditFieldsRow(
            children: [
              AppTextField(
                label: 'Working Period',
                hintText: 'Working Period',
                controller: periodController,
              ),
              AppTextField(
                label: 'Supervisor',
                hintText: 'Supervisor Name',
                controller: supervisorController,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          AppTextField(
            label: 'Duties',
            hintText: 'Duties',
            controller: dutiesController,
          ),
        ],
      ),
    );
  }
}
