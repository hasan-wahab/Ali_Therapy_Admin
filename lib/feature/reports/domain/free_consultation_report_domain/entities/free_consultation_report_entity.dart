import 'package:equatable/equatable.dart';

// ============================================================
// FREE CONSULTATION REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/free-consultation
// ============================================================

class FreeConsultationReportEntity extends Equatable {
  const FreeConsultationReportEntity({
    required this.id,
    required this.visitDate,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.consultantName,
    required this.clinicName,
    required this.fee,
  });

  final String id;
  final String visitDate;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String consultantName;
  final String clinicName;
  final double fee;

  @override
  List<Object?> get props => [
        id,
        visitDate,
        patientName,
        patientPhone,
        patientCnic,
        consultantName,
        clinicName,
        fee,
      ];
}
