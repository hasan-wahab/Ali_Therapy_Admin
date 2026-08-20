import 'package:equatable/equatable.dart';

// ============================================================
// RECONSULTATION REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/reconsultation
// ============================================================

class ReconsultationReportEntity extends Equatable {
  const ReconsultationReportEntity({
    required this.id,
    required this.visitDate,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.consultantName,
    required this.clinicName,
  });

  final String id;
  final String visitDate;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String consultantName;
  final String clinicName;

  @override
  List<Object?> get props => [
        id,
        visitDate,
        patientName,
        patientPhone,
        patientCnic,
        consultantName,
        clinicName,
      ];
}
