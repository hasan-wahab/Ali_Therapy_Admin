import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_app_bar_underline.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';

// ============================================================
// FORM BACK APP BAR
// ------------------------------------------------------------
// Alias of shared AppBackAppBar (same look everywhere).
// ============================================================

class FormBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FormBackAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + AppAppBarUnderline.preferredExtra);

  @override
  Widget build(BuildContext context) {
    return AppBackAppBar(title: title, actions: actions);
  }
}
