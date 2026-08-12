import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ============================================================
// PATIENT FIELDS ROW
// ------------------------------------------------------------
// Always side-by-side so mobile shows more fields without scroll.
// ============================================================

class PatientFieldsRow extends StatelessWidget {
  const PatientFieldsRow({
    super.key,
    required this.children,
    this.gap,
  });

  final List<Widget> children;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final spacing = gap ?? 10.w;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(width: spacing),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
