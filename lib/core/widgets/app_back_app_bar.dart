import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_app_bar_underline.dart';

// ============================================================
// APP BACK APP BAR (shared — whole app)
// ------------------------------------------------------------
// Same look on every screen:
//   - with back → teal back + centered title
//   - no back  → title sits in leading (left)
//   - thick teal underline under the bar
// ============================================================

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    this.title = '',
    this.actions,
    this.showBack = true,
    this.onBack,
  });

  final String title;

  /// Optional trailing actions (same teal icon style).
  final List<Widget>? actions;

  /// When false, title is shown on the leading side (left).
  final bool showBack;

  /// Custom back action (default: AppNavigation.back).
  final VoidCallback? onBack;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + AppAppBarUnderline.preferredExtra);

  @override
  Widget build(BuildContext context) {
    final hasTitle = title.trim().isNotEmpty;

    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: showBack,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leadingWidth: showBack ? null : 220.w,
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.primary,
                size: AppSizes.iconLg,
              ),
              onPressed: onBack ?? () => AppNavigation.back(context),
            )
          : (hasTitle
              ? Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTextStyles.appBarTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              : null),
      title: showBack && hasTitle
          ? Text(title, style: AppTextStyles.appBarTitle)
          : null,
      actions: actions,
      iconTheme: IconThemeData(
        color: AppColors.primary,
        size: AppSizes.iconLg,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.primary,
        size: AppSizes.iconLg,
      ),
      bottom: AppAppBarUnderline.bar,
    );
  }
}
