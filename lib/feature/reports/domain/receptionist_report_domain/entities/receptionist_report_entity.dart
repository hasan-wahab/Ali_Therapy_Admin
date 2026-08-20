import 'package:equatable/equatable.dart';

// ============================================================
// RECEPTIONIST REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/receptionist
// ============================================================

class ReceptionistReportEntity extends Equatable {
  const ReceptionistReportEntity({
    required this.id,
    required this.visitDate,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.receptionistName,
    required this.clinicName,
    required this.amountCollected,
  });

  final String id;
  final String visitDate;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String receptionistName;
  final String clinicName;
  final double amountCollected;

  @override
  List<Object?> get props => [
        id,
        visitDate,
        patientName,
        patientPhone,
        patientCnic,
        receptionistName,
        clinicName,
        amountCollected,
      ];
}
