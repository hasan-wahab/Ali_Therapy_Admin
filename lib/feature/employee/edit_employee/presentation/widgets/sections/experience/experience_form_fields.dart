import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_experience_entry_card.dart';

// ============================================================
// EXPERIENCE FORM FIELDS
// ------------------------------------------------------------
// List of experience entries + Add Experience (UI only).
// ============================================================

class _ExperienceEntryControllers {
  _ExperienceEntryControllers()
      : company = TextEditingController(),
        period = TextEditingController(),
        duties = TextEditingController(),
        supervisor = TextEditingController();

  final TextEditingController company;
  final TextEditingController period;
  final TextEditingController duties;
  final TextEditingController supervisor;

  void dispose() {
    company.dispose();
    period.dispose();
    duties.dispose();
    supervisor.dispose();
  }
}

class EditExperienceFormFields extends StatefulWidget {
  const EditExperienceFormFields({super.key});

  @override
  State<EditExperienceFormFields> createState() =>
      _EditExperienceFormFieldsState();
}

class _EditExperienceFormFieldsState extends State<EditExperienceFormFields> {
  late final List<_ExperienceEntryControllers> _entries;

  @override
  void initState() {
    super.initState();
    _entries = [_ExperienceEntryControllers()];
  }

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.dispose();
    }
    super.dispose();
  }

  void _addExperience() {
    setState(() => _entries.add(_ExperienceEntryControllers()));
  }

  void _removeExperience(int index) {
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
          EditExperienceEntryCard(
            companyController: _entries[i].company,
            periodController: _entries[i].period,
            dutiesController: _entries[i].duties,
            supervisorController: _entries[i].supervisor,
            onDelete: () => _removeExperience(i),
          ),
          if (i < _entries.length - 1) SizedBox(height: 12.h),
        ],
        SizedBox(height: 14.h),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _addExperience,
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
