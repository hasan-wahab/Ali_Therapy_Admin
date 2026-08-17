import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';

// ============================================================
// FORM FIELDS ROW
// ------------------------------------------------------------
// Side-by-side on wide screens, stacked on narrow screens.
// ============================================================

class FormFieldsRow extends StatelessWidget {
  const FormFieldsRow({
    super.key,
    required this.children,
    this.trailing,
  });

  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide =
            AppDevice.isTablet(context) || constraints.maxWidth >= 520.w;

        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(height: 14.h),
                children[i],
              ],
              if (trailing != null) ...[
                SizedBox(height: 14.h),
                Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) SizedBox(width: 12.w),
              Expanded(child: children[i]),
            ],
            if (trailing != null) ...[
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: trailing!,
              ),
            ],
          ],
        );
      },
    );
  }
}
