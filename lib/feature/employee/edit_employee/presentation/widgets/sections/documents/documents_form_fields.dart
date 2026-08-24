import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/image_picker_service.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_document_entry_card.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// DOCUMENTS FORM FIELDS
// ------------------------------------------------------------
// List of document entries + Add Document.
// ============================================================

class DocumentsFormFields extends StatelessWidget {
  const DocumentsFormFields({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final entries = form.documents;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              EditDocumentEntryCard(
                titleController: entries[i].title,
                descriptionController: entries[i].description,
                expiryValue: entries[i].expiry,
                fileName: entries[i].fileName,
                fileBytes: entries[i].fileBytes,
                onExpiryChanged: (value) => form.setDocumentExpiry(i, value),
                onChooseFile: () => _pickDocumentFile(context, i),
                onDelete: () => form.removeDocument(i),
              ),
              if (i < entries.length - 1) SizedBox(height: 12.h),
            ],
            SizedBox(height: 14.h),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: form.addDocument,
                icon: Icon(Icons.add, size: AppSizes.iconSm),
                label: Text(
                  'Add Document',
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

  Future<void> _pickDocumentFile(BuildContext context, int index) async {
    try {
      final file = await sl<ImagePickerService>().pickFromGallery();
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) return;
      form.setDocumentFile(
        index,
        path: file.path,
        name: file.name,
        bytes: bytes,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbar.error(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }
}
