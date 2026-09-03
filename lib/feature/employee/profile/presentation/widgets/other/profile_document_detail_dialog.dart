import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/helpers.dart';
import 'package:ali_therapy_admin/core/widgets/app_form_dialog.dart';
import 'package:ali_therapy_admin/feature/employee/profile/domain/profile_domain/entities/profile_document_entity.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_document_file_preview.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';

// ============================================================
// PROFILE DOCUMENT DETAIL DIALOG
// ------------------------------------------------------------
// Shows one document's fields when a docs row is tapped.
// ============================================================

class ProfileDocumentDetailDialog extends StatelessWidget {
  const ProfileDocumentDetailDialog({
    super.key,
    required this.document,
  });

  final ProfileDocumentEntity document;

  String _display(String value) {
    final text = value.trim();
    if (text.isEmpty || text == '_') return '';
    return text;
  }

  String _expiryText() {
    final raw = _display(document.docExpiry);
    if (raw.isEmpty) return '';
    final parsed = Helpers.tryParseDate(raw);
    if (parsed == null) return raw;
    return Helpers.formatDate(parsed, pattern: 'dd MMM yyyy');
  }

  String _fileName() {
    final raw = _display(document.docFile);
    if (raw.isEmpty) return '';
    final path = raw.split('?').first.replaceAll('\\', '/');
    final name = path.split('/').last;
    if (name.isEmpty) return '';
    return Uri.decodeComponent(name);
  }

  @override
  Widget build(BuildContext context) {
    final title = _display(document.docTitle);
    final description = _display(document.docDescription);
    final expiry = _expiryText();
    final fileUrl = ApiConstants.resolveFileUrl(document.docFile);
    final fileName = _fileName();

    return AppFormDialog(
      title: title.isEmpty ? 'Document' : title,
      icon: Icons.folder_outlined,
      cancelLabel: 'Close',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileInfoRow(label: 'Title', value: title),
          ProfileInfoRow(label: 'Description', value: description),
          ProfileInfoRow(label: 'Expiry', value: expiry),
          Text('File', style: AppTextStyles.bodySmall),
          SizedBox(height: 6.h),
          ProfileDocumentFilePreview(
            fileUrl: fileUrl,
            fileName: fileName,
          ),
        ],
      ),
    );
  }
}

Future<void> showProfileDocumentDetailDialog({
  required BuildContext context,
  required ProfileDocumentEntity document,
}) {
  return showAppFormDialog<void>(
    context: context,
    builder: (_) => ProfileDocumentDetailDialog(document: document),
  );
}
