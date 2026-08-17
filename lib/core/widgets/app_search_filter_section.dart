import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
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
    this.onSearchSubmitted,
  });

  final String searchHint;

  /// When null, only the search field is shown (no filter button).
  final Widget? filtersPanel;

  final ValueChanged<String>? onSearchSubmitted;

  @override
  State<AppSearchFilterSection> createState() => _AppSearchFilterSectionState();
}

class _AppSearchFilterSectionState extends State<AppSearchFilterSection> {
  final TextEditingController _searchController = TextEditingController();
  bool _filtersOpen = false;

  bool get _hasFilters => widget.filtersPanel != null;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() => _filtersOpen = !_filtersOpen);
  }

  void _onSearchSubmitted(String value) {
    if (widget.onSearchSubmitted != null) {
      widget.onSearchSubmitted!(value);
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
                      Icons.filter_alt_outlined,
                      size: AppSizes.iconLg,
                      color: _filtersOpen
                          ? AppColors.surface
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (_hasFilters && _filtersOpen) ...[
          SizedBox(height: 6.h),
          // Keep list visible — filter panel scrolls if tall.
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.38.sh),
            child: SingleChildScrollView(
              child: widget.filtersPanel!,
            ),
          ),
        ],
      ],
    );
  }
}
