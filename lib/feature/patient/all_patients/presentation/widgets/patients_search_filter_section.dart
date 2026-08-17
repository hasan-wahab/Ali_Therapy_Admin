import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';

// ============================================================
// PATIENTS SEARCH FILTER SECTION
// ------------------------------------------------------------
// Uses shared AppSearchFilterSection + patients filters panel.
// ============================================================

class PatientsSearchFilterSection extends StatelessWidget {
  const PatientsSearchFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppSearchFilterSection(
      searchHint: 'Search patients...',
      filtersPanel: PatientsFiltersPanel(),
    );
  }
}
