import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// DASHBOARD SECTION TITLE
// ------------------------------------------------------------
// Small heading above a dashboard section.
// ============================================================

class DashboardSectionTitle extends StatelessWidget {
  const DashboardSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.heading3);
  }
}
