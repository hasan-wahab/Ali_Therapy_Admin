import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// REPORT SEARCH APP BAR
// ------------------------------------------------------------
// Shared report app bar: back + title, expandable search.
// ============================================================

class ReportSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ReportSearchAppBar({
    super.key,
    required this.title,
    this.searchHint = 'Search…',
  });

  final String title;
  final String searchHint;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ReportSearchAppBar> createState() => _ReportSearchAppBarState();
}

class _ReportSearchAppBarState extends State<ReportSearchAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearch() => setState(() => _isSearching = true);

  void _closeSearch() {
    _searchController.clear();
    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: !_isSearching,
      leading: IconButton(
        icon: Icon(
          _isSearching ? Icons.close_rounded : Icons.arrow_back,
          color: AppColors.primary,
          size: AppSizes.iconLg,
        ),
        onPressed: () {
          if (_isSearching) {
            _closeSearch();
            return;
          }
          AppNavigation.back(context);
        },
      ),
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              style: AppTextStyles.body,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            )
          : Text(widget.title, style: AppTextStyles.appBarTitle),
      actions: [
        if (!_isSearching)
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.primary,
              size: AppSizes.iconLg,
            ),
            onPressed: _openSearch,
          ),
        SizedBox(width: 4.w),
      ],
    );
  }
}
