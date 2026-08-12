import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// BIOGRAPHY SECTION
// ============================================================

class BiographySection extends StatelessWidget {
  const BiographySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Biography',
      child: Text('—', style: AppTextStyles.bodySmall),
    );
  }
}
