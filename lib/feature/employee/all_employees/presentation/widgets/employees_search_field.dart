import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// EMPLOYEES SEARCH FIELD
// ------------------------------------------------------------
// Main search box on All Employees (UI only until API wired).
// ============================================================

class EmployeesSearchField extends StatelessWidget {
  const EmployeesSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hintText: 'Search employees...',
      prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
