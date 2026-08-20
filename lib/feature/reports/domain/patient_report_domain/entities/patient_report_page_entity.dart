import 'package:equatable/equatable.dart';

import 'patient_report_entity.dart';

// ============================================================
// PATIENT REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of patient report rows.
// ============================================================

class PatientReportPageEntity extends Equatable {
  const PatientReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<PatientReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
