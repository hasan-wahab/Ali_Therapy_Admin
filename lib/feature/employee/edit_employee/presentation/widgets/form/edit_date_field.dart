import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_date_field.dart';

// ============================================================
// EDIT DATE FIELD
// ------------------------------------------------------------
// Tappable date field using the shared Cupertino picker.
// ============================================================

class EditDateField extends StatelessWidget {
  const EditDateField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.value,
    this.hintText = 'mm/dd/yyyy',
    this.onChanged,
    this.hasError = false,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final bool isRequired;
  final String? value;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool hasError;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return AppDateField(
      label: label,
      isRequired: isRequired,
      value: value,
      hintText: hintText,
      onChanged: onChanged,
      hasError: hasError,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}
