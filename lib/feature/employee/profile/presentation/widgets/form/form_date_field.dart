import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_date_field.dart';

// ============================================================
// FORM DATE FIELD
// ------------------------------------------------------------
// Profile form dates — shared Cupertino picker.
// ============================================================

class FormDateField extends StatelessWidget {
  const FormDateField({
    super.key,
    required this.label,
    this.hintText = 'mm/dd/yyyy',
    this.value,
    this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final String hintText;
  final String? value;
  final ValueChanged<String>? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return AppDateField(
      label: label,
      hintText: hintText,
      value: value,
      onChanged: onChanged,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(today.year + 20, 12, 31),
    );
  }
}
