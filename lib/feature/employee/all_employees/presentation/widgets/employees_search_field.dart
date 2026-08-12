import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// EMPLOYEES SEARCH FIELD
// ------------------------------------------------------------
// Search box at the top of All Employees (UI only).
// ============================================================

class EmployeesSearchField extends StatelessWidget {
  const EmployeesSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Search employees...',
      prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
      textInputAction: TextInputAction.search,
    );
  }
}
