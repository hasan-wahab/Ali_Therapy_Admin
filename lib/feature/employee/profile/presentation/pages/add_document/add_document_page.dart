import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_add_another_button.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_footer_actions.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_screen_header.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/sections/documents/document_form_fields.dart';

// ============================================================
// ADD DOCUMENT PAGE
// ------------------------------------------------------------
// Upload a document with title, file and expiry.
// ============================================================

class AddDocumentPage extends StatelessWidget {
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'Documents'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FormScreenHeader(
                title: 'Add Document',
                subtitle: 'Upload a document with title, file and expiry.',
              ),
              SizedBox(height: 28.h),
              const DocumentFormFields(),
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
