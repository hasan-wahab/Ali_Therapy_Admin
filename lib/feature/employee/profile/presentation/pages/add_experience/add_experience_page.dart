import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_add_another_button.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_footer_actions.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_screen_header.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/experience/experience_form_fields.dart';

// ============================================================
// ADD EXPERIENCE PAGE
// ------------------------------------------------------------
// Add company, working period and duties.
// ============================================================

class AddExperiencePage extends StatelessWidget {
  const AddExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Experience'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormScreenHeader(
                title: 'Add Experience',
                subtitle: 'Add company, working period and duties.',
              ),
              SizedBox(height: 28.h),
              const ExperienceFormFields(),
              SizedBox(height: 20.h),
              const Align(
                alignment: Alignment.centerLeft,
                child: FormAddAnotherButton(),
              ),
              SizedBox(height: 32.h),
              FormFooterActions(
                onClose: () => AppNavigation.back(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
