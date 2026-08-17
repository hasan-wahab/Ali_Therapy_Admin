import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// PATIENTS SEARCH FIELD
// ------------------------------------------------------------
// Main search box on All Patients (UI only until API wired).
// ============================================================

class PatientsSearchField extends StatelessWidget {
  const PatientsSearchField({
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
      hintText: 'Search patients...',
      prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
