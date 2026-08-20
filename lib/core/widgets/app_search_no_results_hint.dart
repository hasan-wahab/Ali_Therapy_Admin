import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP SEARCH NO RESULTS HINT
// ------------------------------------------------------------
// Google-style line under the search bar when search / filter
// did not find a match. Related rows may still show below.
// ============================================================

class AppSearchNoResultsHint extends StatelessWidget {
  const AppSearchNoResultsHint({
    super.key,
    required this.searchQuery,
    required this.hasActiveFilters,
    this.hasRelatedResults = false,
  });

  final String searchQuery;
  final bool hasActiveFilters;
  final bool hasRelatedResults;

  /// Show only after the user searched or applied filters, and
  /// nothing matched that query.
  static bool shouldShow({
    required String searchQuery,
    required bool hasActiveFilters,
    required int searchMatchCount,
    required bool listIsEmpty,
    bool isBusy = false,
  }) {
    if (isBusy) return false;
    final hasSearch = searchQuery.trim().isNotEmpty;
    if (!hasSearch && !hasActiveFilters) return false;
    if (hasSearch) return searchMatchCount == 0;
    return listIsEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final query = searchQuery.trim();
    final hasSearch = query.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 2.w, right: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasSearch)
            Text.rich(
              TextSpan(
                style: AppTextStyles.body,
                children: [
                  const TextSpan(text: 'Your search - '),
                  TextSpan(
                    text: query,
                    style: AppTextStyles.name,
                  ),
                  TextSpan(
                    text: hasActiveFilters
                        ? ' - did not match any records with these filters.'
                        : ' - did not match any records.',
                  ),
                ],
              ),
            )
          else
            Text(
              'No records match the selected filters.',
              style: AppTextStyles.body,
            ),
          SizedBox(height: 2.h),
          Text(
            hasRelatedResults
                ? 'Showing related results below.'
                : 'Try a different search or reset filters.',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
