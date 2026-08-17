import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_footer.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_step.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/bank_details/bank_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/details/details_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/documents/documents_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/education/education_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/experience/experience_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/user_details/user_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';

// ============================================================
// EDIT EMPLOYEE PAGE
// ------------------------------------------------------------
// Step form: User Details → … → Experience.
// ============================================================

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({super.key});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  EditEmployeeStep _step = EditEmployeeStep.userDetails;

  void _goBack() {
    final previous = _step.previous;
    if (previous == null) {
      AppNavigation.back(context);
      return;
    }
    setState(() => _step = previous);
  }

  void _goNext() {
    final next = _step.next;
    if (next == null) {
      AppSnackbar.info(context, 'Submit coming soon');
      return;
    }
    setState(() => _step = next);
  }

  Widget _buildSection() {
    switch (_step) {
      case EditEmployeeStep.userDetails:
        return const UserDetailsSection();
      case EditEmployeeStep.details:
        return const DetailsSection();
      case EditEmployeeStep.bankDetails:
        return const EditBankDetailsSection();
      case EditEmployeeStep.documents:
        return const EditDocumentsSection();
      case EditEmployeeStep.education:
        return const EditEducationSection();
      case EditEmployeeStep.experience:
        return const EditExperienceSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Edit Employee'),
      body: AppTabletSafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 16.h),
                child: _buildSection(),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: EditEmployeeFooter(
                isFirstStep: _step.isFirst,
                isLastStep: _step.isLast,
                onBack: _goBack,
                onNext: _goNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
