import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// FORM BACK APP BAR
// ------------------------------------------------------------
// Teal back button + title for add-form screens.
// ============================================================

class FormBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FormBackAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primary,
          size: AppSizes.iconLg,
        ),
        onPressed: () => AppNavigation.back(context),
      ),
      title: Text(title, style: AppTextStyles.appBarTitle),
    );
  }
}
