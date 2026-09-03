import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_records_grid.dart';

// ============================================================
// PATIENT DETAIL RECORDS SECTION
// ------------------------------------------------------------
// Records tab: grid of record shortcuts.
// ============================================================

class PatientDetailRecordsSection extends StatelessWidget {
  const PatientDetailRecordsSection({
    super.key,
    required this.detail,
  });

  final PatientDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordsGrid(detail: detail);
  }
}
