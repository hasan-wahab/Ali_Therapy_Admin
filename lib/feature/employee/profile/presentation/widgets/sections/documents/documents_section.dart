import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_document_item.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// DOCUMENTS SECTION
// ============================================================

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Documents',
      onAddTap: () => AppNavigation.openAddDocument(context),
      child: ProfileDocumentItem(
        title: 'CNIC',
        expiry: '2206-02-02',
        onOpen: () => AppSnackbar.info(context, 'Open CNIC'),
        onDelete: () => AppSnackbar.warning(context, 'Delete CNIC'),
      ),
    );
  }
}
