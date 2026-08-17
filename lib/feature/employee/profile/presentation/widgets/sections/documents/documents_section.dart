import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_document_item.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_section_card.dart';

// ============================================================
// DOCUMENTS SECTION
// ============================================================

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final documents = profile.documents;

    return ProfileSectionCard(
      title: 'Documents',
      onAddTap: () => AppNavigation.openAddDocument(context),
      child: documents.isEmpty
          ? Text('No documents', style: AppTextStyles.bodySmall)
          : Column(
              children: [
                for (var i = 0; i < documents.length; i++) ...[
                  if (i > 0) SizedBox(height: 10.h),
                  ProfileDocumentItem(
                    title: documents[i].docTitle,
                    expiry: documents[i].docExpiry,
                    onOpen: () => AppSnackbar.info(
                      context,
                      'Open ${documents[i].docTitle}',
                    ),
                    onDelete: () => AppSnackbar.warning(
                      context,
                      'Delete ${documents[i].docTitle}',
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
