import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_search_no_results_hint.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';

// ============================================================
// APP SEARCH FILTER SECTION (shared — whole app)
// ------------------------------------------------------------
// One row: Search field + optional Filter button.
// Filter opens [filtersPanel] below (set filters, then search).
// ============================================================

class AppSearchFilterSection extends StatefulWidget {
  const AppSearchFilterSection({
    super.key,
    this.searchHint = 'Search...',
    this.filtersPanel,
    this.filtersPanelBuilder,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.searchQuery = '',
    this.hasActiveFilters = false,
    this.searchMatchCount = 0,
    this.listIsEmpty = false,
    this.isSearchBusy = false,
  }) : assert(
         filtersPanel == null || filtersPanelBuilder == null,
         'Use either filtersPanel or filtersPanelBuilder, not both.',
       );

  final String searchHint;

  /// When null, only the search field is shown (no filter button).
  final Widget? filtersPanel;

  /// Use this when the filter panel needs access to close itself.
  final Widget Function(VoidCallback closeFilters)? filtersPanelBuilder;

  /// Fires on every keystroke (caller can debounce).
  final ValueChanged<String>? onSearchChanged;

  final ValueChanged<String>? onSearchSubmitted;

  /// Current search text from Bloc / page (used for the no-results line).
  final String searchQuery;

  /// True when clinic / dates / role filters are applied.
  final bool hasActiveFilters;

  /// How many rows matched the search text (0 = none).
  final int searchMatchCount;

  /// True when the list below has no rows at all.
  final bool listIsEmpty;

  /// Hide the hint while a reload is in progress.
  final bool isSearchBusy;

  @override
  State<AppSearchFilterSection> createState() => _AppSearchFilterSectionState();
}

class _AppSearchFilterSectionState extends State<AppSearchFilterSection> {
  final TextEditingController _searchController = TextEditingController();
  bool _filtersOpen = false;

  bool get _hasFilters =>
      widget.filtersPanel != null || widget.filtersPanelBuilder != null;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() => _filtersOpen = !_filtersOpen);
  }

  void _closeFilters() {
    if (!_filtersOpen) return;
    setState(() => _filtersOpen = false);
  }

  void _onSearchSubmitted(String value) {
    if (widget.onSearchSubmitted != null) {
      widget.onSearchSubmitted!(value);
      return;
    }
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!(value);
      return;
    }
    AppSnackbar.info(
      context,
      value.trim().isEmpty
          ? 'Search with current filters (UI only)'
          : 'Search "$value" with filters (UI only)',
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtersPanel =
        widget.filtersPanelBuilder?.call(_closeFilters) ?? widget.filtersPanel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextField(
                controller: _searchController,
                hintText: widget.searchHint,
                prefixIcon: Icon(Icons.search, size: AppSizes.iconMd),
                textInputAction: TextInputAction.search,
                onChanged: widget.onSearchChanged,
                onSubmitted: _onSearchSubmitted,
              ),
            ),
            if (_hasFilters) ...[
              SizedBox(width: 8.w),
              Material(
                color: _filtersOpen ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  onTap: _toggleFilters,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: _filtersOpen
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Icon(
                      _filtersOpen
                          ? Icons.filter_alt_rounded
                          : Icons.filter_alt_outlined,
                      size: AppSizes.iconLg,
                      color:
                          _filtersOpen ? AppColors.surface : AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (AppSearchNoResultsHint.shouldShow(
          searchQuery: widget.searchQuery,
          hasActiveFilters: widget.hasActiveFilters,
          searchMatchCount: widget.searchMatchCount,
          listIsEmpty: widget.listIsEmpty,
          isBusy: widget.isSearchBusy,
        ))
          AppSearchNoResultsHint(
            searchQuery: widget.searchQuery,
            hasActiveFilters: widget.hasActiveFilters,
            hasRelatedResults: !widget.listIsEmpty,
          ),
        if (_hasFilters)
          AnimatedSize(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _filtersOpen
                ? Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 320),
                      // Avoid overshoot; otherwise Opacity/value may exceed 1
                      // and cause layout overflow when translated.
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        final t = value.clamp(0.0, 1.0);
                        return Opacity(
                          opacity: t,
                          child: Transform.translate(
                            offset: Offset(0, (1 - t) * -26.h),
                            child: child,
                          ),
                        );
                      },
                      child: ClipRect(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 0.38.sh),
                          child: SingleChildScrollView(child: filtersPanel),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }
}
