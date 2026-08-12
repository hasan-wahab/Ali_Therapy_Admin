import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/patient/consultant_details/presentation/widgets/other/consultant_field.dart';

// ============================================================
// CONSULTANT REGION GRID
// ------------------------------------------------------------
// Compact 2-column empty/filled region rows for Special Tests.
// ============================================================

class ConsultantRegionGrid extends StatelessWidget {
  const ConsultantRegionGrid({
    super.key,
    required this.regions,
  });

  /// Map of region label → value text (empty → —).
  final Map<String, String> regions;

  @override
  Widget build(BuildContext context) {
    final entries = regions.entries.toList();
    final rows = <Widget>[];

    for (var i = 0; i < entries.length; i += 2) {
      final left = entries[i];
      final right = i + 1 < entries.length ? entries[i + 1] : null;

      rows.add(
        Padding(
            padding: EdgeInsets.only(bottom: 0.h),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConsultantField(
                  label: left.key,
                  value: left.value,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : ConsultantField(
                        label: right.key,
                        value: right.value,
                      ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
