import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_filters_panel.dart';

// ============================================================
// EMPLOYEES SEARCH FILTER SECTION
// ------------------------------------------------------------
// Uses shared AppSearchFilterSection + employees filters panel.
// ============================================================

class EmployeesSearchFilterSection extends StatelessWidget {
  const EmployeesSearchFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppSearchFilterSection(
      searchHint: 'Search employees...',
      filtersPanel: EmployeesFiltersPanel(),
    );
  }
}
