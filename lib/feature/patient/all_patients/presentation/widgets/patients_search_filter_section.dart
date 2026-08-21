import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';

// ============================================================
// PATIENTS SEARCH FILTER SECTION
// ------------------------------------------------------------
// Same flow as Patient Dues:
// SearchChanged (debounced in page) + SearchSubmitted.
// Filter panel Apply closes and updates the list.
// ============================================================

class PatientsSearchFilterSection extends StatelessWidget {
  const PatientsSearchFilterSection({
    super.key,
    required this.clinic,
    required this.receptionist,
    this.fromDate,
    this.toDate,
    required this.onFiltersApply,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.searchQuery = '',
    this.searchMatchCount = 0,
    this.listIsEmpty = false,
    this.hasActiveFilters = false,
    this.isSearchBusy = false,
  });

  final String clinic;
  final String receptionist;
  final String? fromDate;
  final String? toDate;
  final void Function({
    required String clinic,
    required String receptionist,
    String? fromDate,
    String? toDate,
  }) onFiltersApply;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchQuery;
  final int searchMatchCount;
  final bool listIsEmpty;
  final bool hasActiveFilters;
  final bool isSearchBusy;

  @override
  Widget build(BuildContext context) {
    return AppSearchFilterSection(
      searchHint: 'Search patients...',
      onSearchChanged: onSearchChanged,
      onSearchSubmitted: onSearchSubmitted,
      searchQuery: searchQuery,
      searchMatchCount: searchMatchCount,
      listIsEmpty: listIsEmpty,
      hasActiveFilters: hasActiveFilters,
      isSearchBusy: isSearchBusy,
      filtersPanelBuilder: (closeFilters) => PatientsFiltersPanel(
        clinic: clinic,
        receptionist: receptionist,
        fromDate: fromDate,
        toDate: toDate,
        onApply: onFiltersApply,
        onApplied: closeFilters,
      ),
    );
  }
}
