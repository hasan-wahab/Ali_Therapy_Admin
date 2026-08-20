import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/patient-report
// ============================================================

class PatientReportEntity extends Equatable {
  const PatientReportEntity({
    required this.id,
    required this.patientName,
    required this.email,
    required this.visitsCount,
    required this.createdAt,
    required this.createdBy,
  });

  final String id;
  final String patientName;
  final String email;
  final int visitsCount;
  final String createdAt;
  final String createdBy;

  @override
  List<Object?> get props => [
        id,
        patientName,
        email,
        visitsCount,
        createdAt,
        createdBy,
      ];
}
