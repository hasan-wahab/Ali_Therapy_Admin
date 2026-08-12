import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// DASHBOARD SEARCH FIELD
// ------------------------------------------------------------
// Global search box at the top of the dashboard (UI only).
// ============================================================

class DashboardSearchField extends StatelessWidget {
  const DashboardSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: 'Search patients, employees...',
      prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
      textInputAction: TextInputAction.search,
    );
  }
}
