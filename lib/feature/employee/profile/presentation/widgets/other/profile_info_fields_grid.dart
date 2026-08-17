import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/other/profile_info_row.dart';

// ============================================================
// PROFILE INFO FIELDS GRID
// ------------------------------------------------------------
// Phone: one field per row (same as before).
// Tablet: two fields per row — uses empty side space.
// ============================================================

class ProfileInfoField {
  const ProfileInfoField({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileInfoFieldsGrid extends StatelessWidget {
  const ProfileInfoFieldsGrid({super.key, required this.fields});

  final List<ProfileInfoField> fields;

  @override
  Widget build(BuildContext context) {
    if (!AppDevice.isTablet(context)) {
      return Column(
        children: [
          for (final field in fields)
            ProfileInfoRow(label: field.label, value: field.value),
        ],
      );
    }

    final rows = <Widget>[];
    for (var i = 0; i < fields.length; i += 2) {
      final left = fields[i];
      final hasRight = i + 1 < fields.length;
      final right = hasRight ? fields[i + 1] : null;

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProfileInfoRow(label: left.label, value: left.value),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: right == null
                  ? const SizedBox.shrink()
                  : ProfileInfoRow(label: right.label, value: right.value),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}
