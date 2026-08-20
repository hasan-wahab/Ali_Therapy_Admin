import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';

// ============================================================
// PATIENTS SEARCH FILTER SECTION
// ------------------------------------------------------------
// Uses shared AppSearchFilterSection + patients filters panel.
// ============================================================

class PatientsSearchFilterSection extends StatelessWidget {
  const PatientsSearchFilterSection({
    super.key,
    this.onSearchChanged,
    this.searchQuery = '',
    this.searchMatchCount = 0,
    this.listIsEmpty = false,
  });

  final ValueChanged<String>? onSearchChanged;
  final String searchQuery;
  final int searchMatchCount;
  final bool listIsEmpty;

  @override
  Widget build(BuildContext context) {
    return AppSearchFilterSection(
      searchHint: 'Search patients...',
      onSearchChanged: onSearchChanged,
      searchQuery: searchQuery,
      searchMatchCount: searchMatchCount,
      listIsEmpty: listIsEmpty,
      filtersPanelBuilder: (closeFilters) => PatientsFiltersPanel(
        onApplied: closeFilters,
      ),
    );
  }
}
