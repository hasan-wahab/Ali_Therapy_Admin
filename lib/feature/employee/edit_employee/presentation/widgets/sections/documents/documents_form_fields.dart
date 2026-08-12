import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_document_entry_card.dart';

// ============================================================
// DOCUMENTS FORM FIELDS
// ------------------------------------------------------------
// List of document entries + Add Document (UI only).
// ============================================================

class _DocumentEntryControllers {
  _DocumentEntryControllers({
    required String title,
    String description = '',
  })  : title = TextEditingController(text: title),
        description = TextEditingController(text: description);

  final TextEditingController title;
  final TextEditingController description;

  void dispose() {
    title.dispose();
    description.dispose();
  }
}

class DocumentsFormFields extends StatefulWidget {
  const DocumentsFormFields({super.key});

  @override
  State<DocumentsFormFields> createState() => _DocumentsFormFieldsState();
}

class _DocumentsFormFieldsState extends State<DocumentsFormFields> {
  late final List<_DocumentEntryControllers> _entries;

  @override
  void initState() {
    super.initState();
    _entries = [
      _DocumentEntryControllers(title: 'Degree'),
      _DocumentEntryControllers(title: 'Cnic front'),
      _DocumentEntryControllers(title: 'Cnic Back'),
    ];
  }

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.dispose();
    }
    super.dispose();
  }

  void _addDocument() {
    setState(() {
      _entries.add(_DocumentEntryControllers(title: ''));
    });
  }

  void _removeDocument(int index) {
    if (_entries.length <= 1) return;
    setState(() {
      _entries[index].dispose();
      _entries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < _entries.length; i++) ...[
          EditDocumentEntryCard(
            titleController: _entries[i].title,
            descriptionController: _entries[i].description,
            onDelete: () => _removeDocument(i),
          ),
          if (i < _entries.length - 1) SizedBox(height: 12.h),
        ],
        SizedBox(height: 14.h),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _addDocument,
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
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
