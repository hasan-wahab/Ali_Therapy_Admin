import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_date_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_document_file_field.dart';

// ============================================================
// EDIT DOCUMENT ENTRY CARD
// ------------------------------------------------------------
// One document row: title, description, file, expiry, delete.
// ============================================================

class EditDocumentEntryCard extends StatelessWidget {
  const EditDocumentEntryCard({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onDelete,
    this.expiryValue,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onDelete;
  final String? expiryValue;

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
                  label: 'Title',
                  hintText: 'Title',
                  controller: titleController,
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
          AppTextField(
            label: 'Description',
            hintText: 'Document Description',
            controller: descriptionController,
          ),
          SizedBox(height: 10.h),
          const EditDocumentFileField(),
          SizedBox(height: 10.h),
          EditDateField(
            label: 'Expiry',
            value: expiryValue,
            hintText: 'mm/dd/yyyy',
          ),
        ],
      ),
    );
  }
}
