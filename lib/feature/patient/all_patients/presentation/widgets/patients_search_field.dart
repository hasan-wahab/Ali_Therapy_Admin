import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// PATIENTS SEARCH FIELD
// ------------------------------------------------------------
// Search box at the top of All Patients (UI only).
// ============================================================

class PatientsSearchField extends StatelessWidget {
  const PatientsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Search patients...',
      prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
      textInputAction: TextInputAction.search,
    );
  }
}
