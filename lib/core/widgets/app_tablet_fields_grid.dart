import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';

// ============================================================
// APP TABLET FIELDS GRID
// ------------------------------------------------------------
// Lays out fields/widgets in rows:
//   phone  → phoneColumns (default 1 = stacked, same as before)
//   tablet → tabletColumns (default 2 = side-by-side)
// Use for filters, label/value rows, money lines, etc.
// Does not change mobile when phoneColumns matches old layout.
// ============================================================

class AppTabletFieldsGrid extends StatelessWidget {
  const AppTabletFieldsGrid({
    super.key,
    required this.children,
    this.phoneColumns = 1,
    this.tabletColumns = 2,
    this.gapW,
    this.gapH,
  });

  final List<Widget> children;
  final int phoneColumns;
  final int tabletColumns;
  final double? gapW;
  final double? gapH;

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final cols = isTablet ? tabletColumns : phoneColumns;
    final hGap = gapW ?? (isTablet ? 12.w : 6.w);
    final vGap = gapH ?? (isTablet ? 4.h : 0);

    if (cols <= 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0 && vGap > 0) SizedBox(height: vGap),
            children[i],
          ],
        ],
      );
    }

    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += cols) {
      final slice = children.skip(i).take(cols).toList();
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var j = 0; j < cols; j++) ...[
              if (j > 0) SizedBox(width: hGap),
              Expanded(
                child: j < slice.length ? slice[j] : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      );
      if (i + cols < children.length) {
        rows.add(SizedBox(height: vGap > 0 ? vGap : 4.h));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}
