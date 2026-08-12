import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ============================================================
// EDIT FIELDS ROW
// ------------------------------------------------------------
// Always side-by-side on mobile (Name/ID, Clinic/Room).
// ============================================================

class EditFieldsRow extends StatelessWidget {
  const EditFieldsRow({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(width: 10.w),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
