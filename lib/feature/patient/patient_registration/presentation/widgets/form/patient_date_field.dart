import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/widgets/app_date_field.dart';

// ============================================================
// PATIENT DATE FIELD
// ------------------------------------------------------------
// Birth / form dates — shared Cupertino picker.
// ============================================================

class PatientDateField extends StatelessWidget {
  const PatientDateField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.hintText = 'mm/dd/yyyy',
    this.value,
    this.onChanged,
  });

  final String label;
  final bool isRequired;
  final String hintText;
  final String? value;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return AppDateField(
      label: label,
      isRequired: isRequired,
      hintText: hintText,
      value: value,
      onChanged: onChanged,
      firstDate: DateTime(1920),
      lastDate: DateTime(today.year, today.month, today.day),
    );
  }
}
