import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_education_entry_card.dart';

// ============================================================
// EDUCATION FORM FIELDS
// ------------------------------------------------------------
// List of education entries + Add Education (UI only).
// ============================================================

class _EducationEntryControllers {
  _EducationEntryControllers()
      : degree = TextEditingController(),
        university = TextEditingController(),
        cgpa = TextEditingController(),
        comments = TextEditingController();

  final TextEditingController degree;
  final TextEditingController university;
  final TextEditingController cgpa;
  final TextEditingController comments;

  void dispose() {
    degree.dispose();
    university.dispose();
    cgpa.dispose();
    comments.dispose();
  }
}

class EditEducationFormFields extends StatefulWidget {
  const EditEducationFormFields({super.key});

  @override
  State<EditEducationFormFields> createState() =>
      _EditEducationFormFieldsState();
}

class _EditEducationFormFieldsState extends State<EditEducationFormFields> {
  late final List<_EducationEntryControllers> _entries;

  @override
  void initState() {
    super.initState();
    _entries = [_EducationEntryControllers()];
  }

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.dispose();
    }
    super.dispose();
  }

  void _addEducation() {
    setState(() => _entries.add(_EducationEntryControllers()));
  }

  void _removeEducation(int index) {
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
          EditEducationEntryCard(
            degreeController: _entries[i].degree,
            universityController: _entries[i].university,
            cgpaController: _entries[i].cgpa,
            commentsController: _entries[i].comments,
            onDelete: () => _removeEducation(i),
          ),
          if (i < _entries.length - 1) SizedBox(height: 12.h),
        ],
        SizedBox(height: 14.h),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _addEducation,
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
