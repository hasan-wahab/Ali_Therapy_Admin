import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_app_bar_underline.dart';
import 'package:ali_therapy_admin/core/widgets/app_back_app_bar.dart';

// ============================================================
// PATIENT BACK APP BAR
// ------------------------------------------------------------
// Alias of shared AppBackAppBar (same look everywhere).
// ============================================================

class PatientBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PatientBackAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + AppAppBarUnderline.preferredExtra);

  @override
  Widget build(BuildContext context) {
    return AppBackAppBar(title: title);
  }
}
