import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_search_ranker.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_filter_section.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_filters_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_list_query.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_filters_panel.dart';

// ============================================================
// EMPLOYEES SEARCH FILTER SECTION
// ------------------------------------------------------------
// Search → AllEmployeesSearchChanged (debounced in Bloc).
// Filters panel options from API meta + current query.
// ============================================================

class EmployeesSearchFilterSection extends StatelessWidget {
  const EmployeesSearchFilterSection({super.key});

  EmployeesFiltersEntity _filtersOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.filters;
    if (state is AllEmployeesError) return state.filters;
    return const EmployeesFiltersEntity.empty();
  }

  EmployeesListQuery _queryOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.query;
    if (state is AllEmployeesError) return state.query;
    return const EmployeesListQuery();
  }

  List<EmployeeEntity> _rowsOf(AllEmployeesState state) {
    if (state is AllEmployeesLoaded) return state.employees;
    if (state is AllEmployeesError) return state.employees;
    return const [];
  }

  bool _isBusy(AllEmployeesState state) {
    if (state is AllEmployeesLoading || state is AllEmployeesInitial) {
      return true;
    }
    if (state is AllEmployeesLoaded) return state.isRefreshingList;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllEmployeesBloc, AllEmployeesState>(
      buildWhen: (previous, current) {
        return _filtersOf(previous) != _filtersOf(current) ||
            _queryOf(previous) != _queryOf(current) ||
            _rowsOf(previous) != _rowsOf(current) ||
            _isBusy(previous) != _isBusy(current);
      },
      builder: (context, state) {
        final query = _queryOf(state);
        final rows = _rowsOf(state);
        return AppSearchFilterSection(
          searchHint: 'Search employees...',
          searchQuery: query.search,
          hasActiveFilters: query.hasActiveFilters,
          searchMatchCount: AppSearchRanker.matchCount(
            items: rows,
            query: query.search,
            fieldsOf: (row) => [
              row.name,
              row.email,
              row.phone,
              row.cnic,
              row.employeeId,
              ...row.roles,
              row.shift,
              row.createdBy,
            ],
          ),
          listIsEmpty: rows.isEmpty,
          isSearchBusy: _isBusy(state),
          onSearchChanged: (value) {
            context.read<AllEmployeesBloc>().add(
                  AllEmployeesSearchChanged(value),
                );
          },
          onSearchSubmitted: (value) {
            context.read<AllEmployeesBloc>().add(
                  AllEmployeesSearchSubmitted(value),
                );
          },
          filtersPanelBuilder: (closeFilters) => EmployeesFiltersPanel(
            filters: _filtersOf(state),
            query: _queryOf(state),
            onApplied: closeFilters,
          ),
        );
      },
    );
  }
}
